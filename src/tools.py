import json
from urllib.error import HTTPError


def retry(func, *args, count=0, max_count=2, **kwargs):
    while count < max_count:
        try:
            return func(*args, **kwargs)
        except HTTPError as exc:
            print(f"Retrying call to {func} because of HTTPError: '{exc}'")
            count += 1

    raise HTTPError(f"Exceeded max tries to fetch data from api")


def load_content(path: str) -> dict:
        with open(path, "r") as handle:
            return json.loads(handle.read())
