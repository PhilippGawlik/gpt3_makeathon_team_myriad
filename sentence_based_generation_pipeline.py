from typing import Generator, List, Tuple
from urllib.error import HTTPError

from data.text_intent_source_data import TEXT_INTEND_SOURCE_DATA
from src.chatbot_formatting import chatbot_format
from src.open_ai_api import request_gpt3
from src.preprocess import split_into_sentences
from prompts.sentence_based_prompt import (
        QUESTION_PROMPT, QUESTION_SETTINGS, ANSWER_PROMPT, ANSWER_SETTINGS)


def sentence_based_generation_pipeline(
        data: List[Tuple[str, str]]=TEXT_INTEND_SOURCE_DATA,
) -> None:
    """Generate intent-question-answer tripplets from user manual text.

    :param data: user manual data
    :param generation_cycles: number of generation cycles per text
    :param retries: max number of retries
    """
    triplets: List[Tuple[str, str, str]] = []
    for (intent, text) in data:
            try:
                questions_answer_pairs = get_question_answer_pairs(text)
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


def get_question_answer_pairs(text: str) -> List[Tuple[str, str]]:
    """Generate question-answer pairs based on user manual text.

    :param text: user manual text
    """
    sentences = split_into_sentences(text)
    pairs = []
    for sentence in sentences:
        try:
            question = get_question(sentence)
            answer = get_answer(text, question)
        except ValueError:
            continue

        pairs.append((question, answer))

    return pairs


def get_question(
        sentence: str,
        q_prompt: str=QUESTION_PROMPT,
        q_settings: dict=QUESTION_SETTINGS
) -> str:
    """Generate question for user manual sentence.

    :param sentence: user manual sentence
    :param q_prompt: gpt3 prompt for generation
    :param q_settings: gpt3 settings for generation
    """
    q_prompt = q_prompt.format(sentence)
    question = request_gpt3(q_prompt, q_settings)[0]
    question = question.strip()
    if not question[-1] == "?":
        raise ValueError(f"This is not a question: '{question}' so I skip it!")

    return question


def get_answer(
        text: str,
        question: str,
        a_prompt: str=ANSWER_PROMPT,
        a_settings: dict=ANSWER_SETTINGS,
) -> str:
    """Generate answers for usage question.

    :param text: user manual text
    :param question: usage question
    :param q_prompt: gpt3 prompt for generation
    :param q_settings: gpt3 settings for generation
    """
    a_prompt = a_prompt.format(text, question)
    answer = request_gpt3(a_prompt, a_settings)[0]
    answer = answer.strip()
    if not answer:
        raise ValueError(
            f"Got a empty answer for the question: '{question}' so I skip it!"
        )

    return answer


def get_tripplets(
        intent: str,
        questions_answer_pairs: List[Tuple[str, str]]
) -> Generator[Tuple[str, str, str], None, None]:
    """Assemble intent-question-answer triplet.

    :param intent: intent of the user manual text
    :param question_answer_pairs: raw generated paris
    """
    for (q, a) in questions_answer_pairs:
        yield (intent, q, a)


if __name__ == "__main__":
    sentence_based_generation_pipeline()
