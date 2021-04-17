# Takes list of tuples with intent, query and response as members.
# Returns .cvc and .json file with IntentID, IntentName, Query, Response.

from datetime import datetime

import pandas as pd


def chatbot_format(triples, path="{}_dialogflow_corpora"):
    path = path.format(datetime.now().isoformat())
    res = [
        {"IntentName": sub[0], "Query": sub[1], "Response": sub[2]} for sub in triples
    ]
    df = pd.DataFrame(res)
    df["IntentID"] = df.groupby(["IntentName"]).ngroup()
    cols = ["IntentID", "IntentName", "Query", "Response"]
    df = df.loc[:, cols]
    df.to_json(path + ".json", orient="records", lines=True)
    df.to_csv(path + ".csv", index=False)
    return


# triples = [("suitable detergents","What detergents are suitable for dishwashers?", "Both separate and combined detergents are suitable"),
# ("suitable detergents", "How do you get optimum washing and drying results?", "Use separate detergent, adding Special salt and Rinse aid separately."),
# ("separate detergents","What are separate detergents?","Separate detergents are products that do not contain components other than detergent, e.g. powder detergent or liquid detergent."),
# ("arrange tableware", "why do I need to arrange the tableware correctly?", 'Arrange the tableware correctly to optimise the dishwashing result and prevent damage to both the appliance and tableware.') ]

# chatbot_format(triples)
