import re


def preprocess(s: str) -> str:
    """With multiple question-answer generation attempts the listing numbers
       have to be removed.

    :param s: question/answer string to be preprocessed
    """
    return re.sub(r"^\d\.\s*", "", s)
