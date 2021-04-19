import os

import openai

openai.api_key = os.getenv("OPENAI_API_KEY")


def request_gpt3(prompt: str, settings: dict):
    """Request a generated text from gpt3.

    :param prompt: prompt to post to gpt3
    :param settings: gpt3 settings for request
    """
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
