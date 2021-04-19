from typing import Any, Generator, List

from src.tools import load_content


FOLLOW_UP_KEYS = [
    "$",
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
    """Chapter model."""
    def __init__(
            self,
            intent: str,
            desc: str,
            text: str,
            subchapters: List["SubChapter"]
    ):
        """Init method.

        :param intent: intent of the chapter
        :param desc: description of the chapter
        :param text: text of the chapter
        :param subchapters: subchapters of the chapter
        """
        self._intent = intent
        self._desc = desc
        self._text = text
        self._subchapters = subchapters

    @classmethod
    def from_dict(cls, raw: dict) -> "Chapter":
        """Init chapter from dictionary.

        :param raw: dictionary holding chapter content
        """
        intent = raw["title"]["$"]
        desc = raw["shortdesc"]["$"]
        text = parse_list(raw["BSHCollectionOfElements"])
        subchapters = list(parse_subchapters(raw["BSHCollectionOfElements"]))
        return cls(intent, desc, text, subchapters)

    def __str__(self) -> str:
        """Return printable version of the chapter."""
        if self._subchapters is not None:
            sub_as_str = "\n".join([str(s) for s in self._subchapters])

        return (
            f"intent: {self._intent}\n"
            f"desc: {self._desc}\n"
            f"text: {self._text}\n"
            f"subchapters:\n{sub_as_str}"
        )


class SubChapter(Chapter):
    """Subchapter model."""
    def __init__(self, intent: str, desc: str, text: str):
        """Init method.

        :param intent: uid of the product described by the manual
        :param chapters: chapters of the user manual
        """
        self._intent = intent
        self._desc = desc
        self._text = text

    @classmethod
    def from_dict(cls, raw: dict) -> "SubChapter":
        """Init subchapter from dictionary.

        :param raw: dictionary holding subchapter content
        """
        intent = raw["title"]["$"]
        desc = raw["shortdesc"]["$"]
        try:
            text = parse_list(raw["BSHCollectionOfElements"])
        except KeyError:
            text = parse_list(raw["p"]["BSHCollectionOfElements"])

        return cls(intent, desc, text)

    def __str__(self) -> str:
        """Return printable version of the subchapter."""
        return (
            f"\tintent: {self._intent}\n\t"
            f"desc: {self._desc}\n\t"
            f"text: {self._text}"
        )


class Manual:
    """User manual model."""
    def __init__(self, product_uid: str, chapters: List[Chapter]=None) -> None:
        """Init method.

        :param product_uid: uid of the product described by the manual
        :param chapters: chapters of the user manual
        """
        self._product_uid = product_uid
        self._chapters = chapters or []

    def add_chapter(self, raw: dict) -> None:
        """Add chapter to user manual model.

        :param raw: user manual content
        """
        self._chapters.append(Chapter.from_dict(raw))

    def __str__(self) -> str:
        """Return printable version of the manual."""
        return "\n".join([str(c) for c in self._chapters])


def extract_from_files(
    product_uid: str,
    product_source_files: List[str]
) -> Manual:
    """Extract intent, description and text body from manual source files.

    :param product_id: id of the product described in the manual
    :param product_source_files: list of product manual source files
    """
    manual = Manual(product_uid)
    for path in product_source_files:
        raw = load_content(path)
        manual.add_chapter(raw)

    return manual


def parse_subchapters(raw: dict) -> Generator[SubChapter, None, None]:
    """Parse subchapters in the manual source file.

    :param raw: object including sub chapters
    """
    for para in raw:
        if "node" in para:
            yield SubChapter.from_dict(para["node"])


def parse_list(raw: List[Any], follow_up_keys: List[str]=None) -> str:
    """Parse list of content nodes to extract product information.

    :param raw: content including user manual information
    :param follow_up_keys: keys holding relevant user manual information
    """
    buffer_ = []
    for para in raw:
        try:
            phrase = parse_para(para, follow_up_keys=follow_up_keys)
        except (KeyError, ValueError):
            continue
        else:
            buffer_.append(phrase)

    return " ".join(buffer_)


def parse_para(para: Any, follow_up_keys: List[str]=None) -> str:
    """Parse paragraph object to extract product information.

    :param para: paragraph object that might hold relevant user manual
                 information
    :param follow_up_keys: keys holding relevant user manual information
    """
    if isinstance(para, str):
        return para
    elif isinstance(para, dict):
        for key in FOLLOW_UP_KEYS:
            val = para[key]
            return parse_para(val)
    elif isinstance(para, list):
        return parse_list(para)

    raise TypeError("Don't know what to do with: {raw}")


def parse_dict(raw: dict, follow_up_keys: List[str]=None) -> str:
    """Parse content node to extract relevant product information.

    :param raw: content including user manual information
    :param follow_up_keys: keys holding relevant user manual information
    """
    follow_up_keys = follow_up_keys or FOLLOW_UP_KEYS
    for key in FOLLOW_UP_KEYS:
        val = raw[key]
        return parse_para(val)

    raise ValueError("Can't find : {raw}")
