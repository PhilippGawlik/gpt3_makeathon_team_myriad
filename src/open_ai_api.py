import os

import openai

openai.api_key = os.getenv("OPENAI_API_KEY")


QUESTION_PROMPT = (
    "This is a question making problem."
    " Read the following text\n'''\n{}'''\n"
    "Create a maximum of four text related questions:\n1."
)

ANSWER_PROMPT = (
    'Read the following text and answer the questions'
    '\n"""\n'
    '{}'
    '\n"""\n'
    'Answer the questions related to the previous text:\n'
    '{}'
    '\nAnswers:\n1.'
)

QUESTION_SETTING = {
    "temperature": 0.8,
    "max_tokens": 64,
    "top_p": 1.0,
    "frequency_penalty": 0.1,
    "presence_penalty": 0.14,
    "stop": ["\n\n"]
}
ANSWER_SETTING = {
    "temperature": 0.8,
    "max_tokens": 64,
    "top_p": 1.0,
    "frequency_penalty": 0.1,
    "presence_penalty": 0.14,
    "stop": ["\n\n"]
}


def generate_questions(
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
    return questions


def generate_answers(
        text, questions, settings=ANSWER_SETTING, prompt=ANSWER_PROMPT):
    questions[0] = "1. {}".format(questions[0])
    str_questions = "\n".join(questions)
    prompt = prompt.format(text, str_questions)
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
    return answers
