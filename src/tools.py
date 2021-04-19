import json
from typing import Any, Callable
from urllib.error import HTTPError


def retry(
    func: Callable,
    *args: list,
    count: int = 0,
    max_count: int = 2,
    **kwargs: dict
) -> Any:
    """Retry in case of error.

    :param func: function to execude
    :param args: arguments of the executed function
    :param count: start counting the retries with
    :param max_count: max number of retries
    :param kwargs: keyword arguments
    """
    while count < max_count:
        try:
            return func(*args, **kwargs)
        except HTTPError as exc:
            print(f"Retrying call to {func} because of HTTPError: '{exc}'")
            count += 1

    raise HTTPError("Exceeded max tries to fetch data from api")


def load_content(path: str) -> dict:
    """Load json content from file.

    :param path: path to json file
    """
    with open(path, "r") as handle:
        return json.loads(handle.read())
