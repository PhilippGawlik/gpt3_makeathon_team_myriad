import re
from typing import List


def preprocess(s: str) -> str:
    """With multiple question-answer generation attempts the listing numbers
       have to be removed.

    :param s: question/answer string to be preprocessed
    """
    return re.sub(r"^\d\.\s*", "", s)


def split_into_sentences(text: str) -> List[str]:
    """"Split text into sentences.

    :param text: text to split
    """
    sentences = text.split(".")
    return [f"{s.strip()}." for s in sentences]
