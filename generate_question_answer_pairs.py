import re
from typing import List, Tuple
from urllib.error import HTTPError

from data.text_intent_source_data import TEXT_INTEND_SOURCE_DATA
from src.open_ai_api import generate_answer, generate_question
from src.chatbot_formatting import chatbot_format
from src.tools import retry


def preprocess_text(text):
    sentences = text.split(".")
    return [f"{s.strip()}." for s in sentences]


def pipeline(
        data: List[Tuple[str, str]]=TEXT_INTEND_SOURCE_DATA,
        attempts_per_intent=3,
        retries=1
):
    triplets = []
    for (intent, text) in data:
        questions_answer_pairs = get_question_answer_pairs(text)
        for (q, a) in questions_answer_pairs:
            q = preprocess(q)
            a = preprocess(a)
            triplets.append((intent, q, a))

    if triplets:
        chatbot_format(triplets)
    else:
        print(f"Did not generate any tripplets!")


def get_question_answer_pairs(text):
    sentences = preprocess_text(text)
    pairs = []
    for sentence in sentences:
        question = generate_question(sentence)
        question = question.strip()
        if not question[-1] == "?":
            print(f"This is not a question: '{question}' so I skip it!")
            continue

        answer = generate_answer(text, question)
        answer = answer.strip()
        answer = answer.strip('"')
        if not answer:
            print(f"Got a empty answer for the question: '{question}' so I skip it!")
            continue

        pairs.append((question, answer))

    return pairs


def preprocess(s: str) -> str:
    return re.sub(r"^\d\.\s*", "", s)


if __name__ == "__main__":
    pipeline()
