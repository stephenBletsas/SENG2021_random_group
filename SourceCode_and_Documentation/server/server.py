import sys
import json
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
def weather():
    dattime = 1619190000
    lat = -33.932999
    lon = 151.259003

    url = 'http://api.openweathermap.org/data/2.5/forecast?lat={}&lon={}&appid=094385d28744303ab7695075f34baf94'
    url = url.format(lat,lon)

    print(url)

    req = requests.get(url)
    response = req.json()

    toReturn = list()
    temp_dict = {'temp': '','description' : ''}
    for elem in response["list"]:
        if elem['dt'] == dattime:   
            temp_dict['temp'] = elem['main']['temp']
            x = elem['weather'][0]
            temp_dict['description'] = x['description']

    return dumps(temp_dict)


# if __name__ == "__main__":
#    APP.run()
