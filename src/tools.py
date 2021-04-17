import json


def load_content(path: str) -> dict:
        with open(path, "r") as handle:
            return json.loads(handle.read())
