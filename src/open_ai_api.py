import os

import openai

openai.api_key = os.getenv("OPENAI_API_KEY")


QUESTION_PROMPT = (
)

ANSWER_PROMPT = (
    'Read the following text and answer the questions'
    '\n"""\n'
    '{}'
    '\n"""\n'
)

QUESTION_SETTING = {
}
ANSWER_SETTING = {
    "top_p": 1.0,
    "frequency_penalty": 0.1,
    "presence_penalty": 0.14,
    "stop": ["\n\n"]
}


def generate_question(
        text, settings=QUESTION_SETTING, prompt=QUESTION_PROMPT):
    prompt = prompt.format(text)
    response = openai.Completion.create(
        engine="davinci-instruct-beta",
        prompt=prompt,
        temperature=settings["temperature"],
        max_tokens=settings["max_tokens"],
        top_p=settings["top_p"],
        frequency_penalty=settings["frequency_penalty"],
        presence_penalty=settings["presence_penalty"],
        stop=settings["stop"],
        )
    questions = response["choices"][0]["text"].split("\n")
    return questions[0]


def generate_answer(
        text, question, settings=ANSWER_SETTING, prompt=ANSWER_PROMPT):
    prompt = prompt.format(text, question)
    response = openai.Completion.create(
        engine="davinci-instruct-beta",
        prompt=prompt,
        temperature=settings["temperature"],
        max_tokens=settings["max_tokens"],
        top_p=settings["top_p"],
        frequency_penalty=settings["frequency_penalty"],
        presence_penalty=settings["presence_penalty"],
        stop=settings["stop"],
    )
    answers = response["choices"][0]["text"].split("\n")
    return answers[0]


