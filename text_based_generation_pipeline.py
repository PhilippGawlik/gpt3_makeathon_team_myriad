from typing import Generator, Iterator, List, Tuple
from urllib.error import HTTPError

from data.text_intent_source_data import TEXT_INTEND_SOURCE_DATA
from src.chatbot_formatting import chatbot_format
from src.open_ai_api import request_gpt3
from src.preprocess import preprocess
from src.tools import retry
from prompts.text_based_prompt import (
        QUESTION_PROMPT, QUESTION_SETTINGS, ANSWER_PROMPT, ANSWER_SETTINGS)


def text_based_generation_pipeline(
        data: List[Tuple[str, str]]=TEXT_INTEND_SOURCE_DATA,
        generation_cycles: int=3,
        retries: int=1
) -> None:
    """Generate intent-question-answer tripplets from user manual text.

    :param data: user manual data
    :param generation_cycles: number of generation cycles per text
    :param retries: max number of retries
    """
    triplets: List[Tuple[str, str, str]] = []
    for (intent, text) in data:
        for _ in range(generation_cycles):
            try:
                questions_answer_pairs = retry(
                    get_question_answer_pairs, text,
                    max_count=retries
                )
            except (ValueError, HTTPError):
                print((
                    f"Not been able to generate equal amount of"
                    f" question-answer pairs for intent: {intent}"))
                continue

            triplets.extend(get_tripplets(intent, questions_answer_pairs))

    if triplets:
        chatbot_format(triplets)
    else:
        print(f"Did not generate any tripplets!")


def get_question_answer_pairs(text: str) -> Iterator[Tuple[str, str]]:
    """Generate question-answer pairs based on user manual text.

    :param text: user manual text
    """
    questions = get_questions(text)
    answers = get_answers(text, questions)
    if not len(questions) == len(answers):
        if len(questions) > len(answers):
            del questions[-1]
        elif len(questions) < len(answers):
            del answers[-1]

        if not len(questions) == len(answers):
            raise ValueError("Amount of questions and answers differs!")

    return zip(questions, answers)


def get_questions(
        text: str,
        q_prompt: str=QUESTION_PROMPT,
        q_settings: dict=QUESTION_SETTINGS
) -> List[str]:
    """Generate questions for user manual text.

    :param text: user manual text
    :param q_prompt: gpt3 prompt for generation
    :param q_settings: gpt3 settings for generation
    """
    q_prompt = q_prompt.format(text)
    return request_gpt3(q_prompt, q_settings)


def get_answers(
        text: str,
        questions: List[str],
        a_prompt: str=ANSWER_PROMPT,
        a_settings: dict=ANSWER_SETTINGS,
) -> List[str]:
    """Generate questions for user manual text.

    :param text: user manual text
    :param q_prompt: gpt3 prompt for generation
    :param q_settings: gpt3 settings for generation
    """
    questions[0] = "1. {}".format(questions[0])
    questions_as_str = "\n".join(questions)
    a_prompt = a_prompt.format(text, questions_as_str)
    return request_gpt3(a_prompt, a_settings)


def get_tripplets(
        intent: str,
        questions_answer_pairs: List[Tuple[str, str]]
) -> Generator[Tuple[str, str, str], None, None]:
    """Assemble intent-question-answer triplet.

    :param intent: intent of the user manual text
    :param question_answer_pairs: raw generated paris
    """
    for (q, a) in questions_answer_pairs:
        yield (
            intent,
            preprocess(q),
            preprocess(a)
        )


if __name__ == "__main__":
    text_based_generation_pipeline()
