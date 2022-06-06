import logging
import azure.functions as func

import json
import logging

from opencensus.extension.azure.functions import OpenCensusExtension
from opencensus.trace import config_integration

OpenCensusExtension.configure()

def main(documents: func.DocumentList, msg: func.Out[str]) -> str:
    if documents:
        logging.info('Analyzed trip id: %s', documents[0]['id'])

        msg.set(documents[0]['id'])

