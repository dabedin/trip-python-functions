import logging

import azure.functions as func


def main(documents: func.DocumentList, msg: func.Out[str]) -> str:
    if documents:
        logging.info('Analyzed trip id: %s', documents[0]['id'])

        msg.set(documents[0]['id'])

