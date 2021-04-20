from typing import Generator, List
 #the special types defined in the typing module. These types add syntax for 
 #specifying the types of elements of composite types.
 # start with capital letters and use square brackets to define itemtypes
from src.tools import load_content


RELEVANT_KEYS = [
    "link",
    "hint",
    "p",
    "BSHCollectionOfElements",
    "property",
    "propvalue",
    "properties",
    "propvalue",
    "variable"
]


class Chapter:
    def __init__(
            self,
            intend: str,
            desc: str,
            text: str,
            subchapters: List["SubChapter"]
    ):
        self._intent = intend
        self._desc = desc
        self._text = text
        self._subchapters = subchapters

    @classmethod
    def from_dict(cls, raw: dict) -> "Chapter":
        intent = raw["title"]["$"]
        desc = raw["shortdesc"]["$"]
        text = parse_list(raw["BSHCollectionOfElements"])
        subchapters = list(parse_subchapters(raw["BSHCollectionOfElements"]))
        return cls(intent, desc, text, subchapters)

    def __str__(self) -> str:
        if self._subchapters is not None:
            sub_as_str = "\n".join([s.__str__() for s in self._subchapters])

        return (
            f"intent: {self._intent}\n"
            f"desc: {self._desc}\n"
            f"text: {self._text}\n"
            f"subchapters:\n{sub_as_str}"
        )


class SubChapter(Chapter):
    def __init__(
            self,
            intend: str,
            desc: str,
            text: str,
    ):
        self._intent = intend
        self._desc = desc
        self._text = text

    @classmethod
    def from_dict(cls, raw: dict) -> "SubChapter":
        intent = raw["title"]["$"]
        desc = raw["shortdesc"]["$"]
        try:
            text = parse_list(raw["BSHCollectionOfElements"])
        except KeyError:
            text = parse_list(raw["p"]["BSHCollectionOfElements"])

        return cls(intent, desc, text)

    def __str__(self) -> str:
        return (
            f"\tintent: {self._intent}\n\t"
            f"desc: {self._desc}\n\t"
            f"text: {self._text}"
        )


class Manual:
    def __init__(self, product_uid: str, chapters: List[Chapter]=None) -> None:
        self._product_uid = product_uid
        self._chapters = chapters or []

    def add_chapter(self, raw: dict) -> None:
        self._chapters.append(Chapter.from_dict(raw))

    def __str__(self) -> str:
        out: List[str] = []
        for c in self._chapters:
            out.append(c.__str__())

        return "\n".join(out)


def parse_subchapters(raw: dict) -> Generator[SubChapter, None, None]:
    for para in raw:
        if "node" in para:
            yield SubChapter.from_dict(para["node"])


def parse_list(raw: List[dict], relevant_keys: List[str]=None) -> str:
    buffer_ = []
    for para in raw:
        try:
            phrase = parse_dict(para, relevant_keys=relevant_keys)
        except KeyError:
            continue
        else:
            buffer_.append(phrase)

    return " ".join(buffer_)


def parse_dict(d, relevant_keys: List[str]=None, verbose: bool=False) -> str:
    relevant_keys = relevant_keys or RELEVANT_KEYS
    if isinstance(d, str):
        return d

    if "$" in d:
        val = d["$"]
        if isinstance(val, list):
            return parse_list(val)
        elif isinstance(val, dict):
            return parse_dict(val)
        elif isinstance(val, str):
            return val
        else:
            raise ValueError(f"What is this: {val}")

    for key in RELEVANT_KEYS:
        if key in d:
            val = d[key]
            if isinstance(val, list):
                return parse_list(val)
            elif isinstance(val, dict):
                return parse_dict(val)
            else:
                raise ValueError(f"What is this: {val}")

    if verbose:
        print(f"Did not find text in {d}")

    raise KeyError


def extract_from_files(
    product_uid: str,
    product_source_files: List[str]
) -> Manual:
    manual = Manual(product_uid)
    for path in product_source_files:
        raw = load_content(path)
        manual.add_chapter(raw)

    return manual


if __name__ == "__main__":
    product_uid = "SMS8YCI01E"
    chapter_source_files = [
        "data/json/SMS8YCI01E/1455288459.json"
    ]
    manual = extract_from_files(product_uid, chapter_source_files)
    print(manual)
