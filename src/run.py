from typing import List
import json


class Product:
    pass


def extract_from_files(
    product_uid: str,
    product_source_files: List[str]
) -> Product:
    for path in product_source_files:
        content = load_content(path)
        breakpoint()
        print(content)

    return Product()


def load_content(path: str) -> dict:
        with open(path, "r") as handle:
            return json.loads(handle.read())


if __name__ == "__main__":
    print("ping")
    product_uid = "SMS8YCI01E"
    product_source_files = [
        "data/json/1455288459.json"
    ]
    product = extract_from_files(product_uid, product_source_files)
