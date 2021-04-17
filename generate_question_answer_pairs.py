import re
from typing import List, Tuple
from urllib.error import HTTPError

from data.text_intent_source_data import TEXT_INTEND_SOURCE_DATA
from src.open_ai_api import generate_answers, generate_questions
from src.chatbot_formatting import chatbot_format
from src.tools import retry


def pipeline(data: List[Tuple[str, str]]=TEXT_INTEND_SOURCE_DATA, retries=1):
    triplets = []
    for (intent, text) in data:
        try:
            questions_answer_pairs = retry(
                get_question_answer_pairs, text,
                max_count=retries
            )
        except (ValueError, HTTPError):
            print((
                f"Not been able to generate equal amount of question answer"
                f" pairs for intent: {intent}"))
            continue

        for (q, a) in questions_answer_pairs:
            q = preprocess(q)
            a = preprocess(a)
            triplets.append((intent, q, a))

    if triplets:
        chatbot_format(triplets)
    else:
        print(f"Did not generate any tripplets!")



def get_question_answer_pairs(text):
    questions = generate_questions(text)
    answers = generate_answers(text, questions)
    if not len(questions) == len(answers):
        raise ValueError("Amount of questions and answers differs!")

    return zip(questions, answers)


def preprocess(s: str) -> str:
    return re.sub(r"^\d\.\s*", "", s)


if __name__ == "__main__":
    pipeline()
