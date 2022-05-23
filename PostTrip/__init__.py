import logging

import azure.functions as func
import uuid
import json
from datetime import datetime

def main(req: func.HttpRequest, doc: func.Out[func.Document]) -> func.HttpResponse:
    request_body = req.get_json()

    id = str(uuid.uuid4())
    newproduct_dict = {
        "id": id,
        "/id": id, 
        "content": "arbitrary data of trip {id} uploaded on {date}".format(id=id, date=datetime.today().strftime('%Y-%m-%d-%H:%M:%S')),
        "data": request_body['payload']
    }
    
    logging.info('Posted trip id: %s', id)

    doc.set(func.Document.from_dict(newproduct_dict))

    return func.HttpResponse (
        json.dumps({'id': id})
        ) 

