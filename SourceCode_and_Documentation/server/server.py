import sys
from json import dumps
from flask import Flask, request, url_for
from flask_cors import CORS
#from error import InputError, AccessError
from werkzeug.exceptions import HTTPException, NotFound
import requests

def defaultHandler(err):
    response = err.get_response()
    print('response', err, err.get_response())
    response.data = dumps({
        "code": err.code,
        "name": "System Error",
        "message": err.get_description(),
    })
    response.content_type = 'application/json'
    return response

APP = Flask(__name__)
CORS(APP)

APP.config['TRAP_HTTP_EXCEPTIONS'] = True
APP.register_error_handler(Exception, defaultHandler)


@APP.route('/hello', methods=['GET'])
def hello():
    return "hello world"

@APP.route('/weather', methods=['GET'])
def event():
    lat = '-33.932999'
    lon = '151.259003'

    request = 'api.openweathermap.org/data/2.5/forecast?lat={}&lon={}&appid=094385d28744303ab7695075f34baf94'
    request.format(lat,lon)
    req = requests.get('')

    response = req.json()
    for event in response["_embedded"]["events"]:
        #for event2 in event["events"]:
        our_events.append(event["name"])
    return dumps(our_events)


if __name__ == "__main__":
   APP.run()
