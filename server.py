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

#eventbrite API {datetime, image, location, description}
@APP.route('/event', methods=['GET'])
def event():
    data = request.args.get('datetime')
    #datetime format 2021-04-20T22:38:00Z
    data2 = f'{data[:4]}-{data[5:7]}-{data[8:10]}T23:59:59Z'
    req = requests.get(f'https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&locale=*&startDateTime={data}&endDateTime={data2}&city=Sydney&countryCode=AU&stateCode=NSW')
    response = req.json()
    our_events = []
    try:
        for event in response["_embedded"]["events"]:
            my_dict = dict()
            my_dict['name'] = event["name"]
            my_dict['location'] = event["_embedded"]["venues"][0]["name"]
            my_dict['image'] = event["images"][0]["url"]
            my_dict['datetime'] = event["dates"]["start"]["dateTime"]
            my_dict['description'] = event["info"]
            our_events.append(my_dict)
    except:
        #no events found
        our_events = []
    return dumps(our_events)

#run app like this:
#FLASK_APP=server.py flask run

#the following is depricated
#if __name__ == "__main__":
#    APP.run()
