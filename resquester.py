import os
import openai
from nltk.util import ngrams
openai.api_key = os.getenv("OPENAI_API_KEY")


def generate_questions(text):
    prompt = f"This is a question making problem. Read the following text\n'''\n{text}'''\nCreate a maximum of four text related questions:\n1."

    response = openai.Completion.create(
        engine="davinci-instruct-beta",
        prompt=prompt,
        temperature=0.8,
        max_tokens=64,
        top_p=1.0,
        frequency_penalty=0.1,
        presence_penalty=0.14,
        stop=["\n\n"]
        )

    questions = response["choices"][0]["text"].split("\n")

    return questions


def generate_answers(text):
    prompt = f"This is a question making problem. Read the following text\n'''\n{text}'''\nCreate a maximum of four text related questions:\n1."

    response = openai.Completion.create(
        engine="davinci-instruct-beta",
        prompt=prompt,
        temperature=0.8,
        max_tokens=64,
        top_p=1.0,
        frequency_penalty=0.1,
        presence_penalty=0.14,
        stop=["\n\n"]
        )

    questions = response["choices"][0]["text"].split("\n")

    return questions


def evaluate(text):
    trigrams = [list(ngrams(sentence.split(), 3)) for sentence in text]

    return trigrams


# text = "Avoid risks to children and vulnerable persons. This appliance may be used by children aged 8 or over and by people who have reduced physical, sensory or mental abilities or inadequate experience and/or knowledge, provided that they are supervised or have been instructed on how to use the appliance safely and have understood the resulting dangers. Children must not play with the appliance. Cleaning and user maintenance must not be performed by children unless they are being supervised. Keep children under the age of 8 years away from the appliance and power cable."
# questions = generate_questions(text)
# questions = [" What is the name of the appliance?", 
#             "2. What is the maximum age for children to use the appliance?",
#             "3. What are some of the dangers of this appliance?", 
#             "4. Who can maintain the appliance?"]

# evaluate(questions)
