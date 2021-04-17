from src.open_ai_api import generate_answers, generate_questions
from src.chatbot_formatting import chatbot_format

import re

INTENT = "Suitable detergents"
TEXT = "Only use detergents that are suitable for dishwashers. Both separate and combined detergents are suitable.  For optimum washing and drying results, use separate detergent, adding Special salt and Rinse aid separately. Modern, powerful detergents mainly use a low-alkaline formulation with enzymes. Enzymes break down starch and remove protein. Oxygen-based bleaching agents are generally used to remove coloured marks, e.g. tea or ketchup. Follow the manufacturer's instructions for each detergent. Tabs are suitable for all cleaning functions and do not need to be measured out. With shorter Programmes tabs sometimes do not dissolve entirely and leave residues of detergent. This may impair the cleaning effect. Powder detergent is recommended for shorter Programmes . The dosage can be adjusted to the level of soiling. The dosage can be adjusted to the level of soiling. Suitable detergents are available online via our website or from Customer Service ."


def preprocess(s: str) -> str:
    return re.sub(r"^\d\.\s*", "", s)


def pipeline():
    data = [(INTENT, TEXT)]
    triplets = []
    for (intent, text) in data:
        questions = generate_questions(text)
        answers = generate_answers(text, questions)
        assert len(answers) == len(questions)
        for (q, a) in zip(questions, answers):
            q = preprocess(q)
            a = preprocess(a)
            triplets.append((intent, q, a))

    chatbot_format(triplets)


if __name__ == "__main__":
    pipeline()
