Myriad - Question Answer pair generator
=============

This is the result of a 48 hour run to write a gpt3 based text generation solution. The objective was to generate training data for chatbots based on companies (BSH in this makeathon) product user manuals. The objective was given to team MYRIAD in the context of TUM.ai's 2021 makeathon and the MYRIAD team was able to enter the finals with this approach and rank 8th place of 45 teams.

The MYRIAD team consists of:

[Kathy-Ann Heitmeier](https://github.com/kheitm)

[Christian Hammacher](https://github.com/chris-h2o)

[Miguel Â. Simões Valente](https://github.com/miguelvalente)

[Robin Strohmeyer](https://github.com/robinstrohmeyer)

[Philipp Gawlik](https://github.com/PhilippGawlik)


Usage
------------

NOTE: The gpt3 text generation prompt's are not included in this repository. This repo includes merely the pipline and frontend code used for the makeathon. To run this project you need to add gpt3 prompt source files to ``promts/`` folder (see given example).

Run user manual text extraction with ``python extract_from_manual.py``

Run text based question answer pair generation with ``python text_based_generation_pipeline.py``

Run sentence based question answer pair generation with ``python sentence_based_generation_pipeline.py``

Canvas
------------

.. image:: doc/lean-canvas.png
    :width: 1610
    :align: center
    :height: 871


Frontend
--------
![image alt text](https://img.youtube.com/vi/9bYt03_oxCA/0.jpg)
[link text](https://www.youtube.com/watch?v=9bYt03_oxCA "Prototype")
