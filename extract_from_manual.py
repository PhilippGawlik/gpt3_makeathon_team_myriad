from src.extract import extract_from_files


PRODUCT_UID = "SMS8YCI01E"
CHAPTER_SOURCE_FILES = [
    "data/json/SMS8YCI01E/1455288459.json"
]


if __name__ == "__main__":
    manual = extract_from_files(
        PRODUCT_UID, CHAPTER_SOURCE_FILES)
    print(manual)
