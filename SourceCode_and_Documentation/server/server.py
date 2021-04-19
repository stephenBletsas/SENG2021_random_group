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

@APP.route('/event', methods=['GET'])
def event():
    data = request.args.get('datetime')
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

@APP.route('/restaurant', methods=['GET'])
def restaurant():
    
    headers = {"Authorization": "Bearer ogcfnTUH24f20GImeBgHY7r90WNlgPEQrQTIHXSKhq9L-nj1-nBvosyAyoJ9eLingqAqjd1tC8lJs0rzyESrzii4GLK2IrkrzpJZZdAWxFywUB98HzPWQ51hQlZ9YHYx"}
    url = 'https://api.yelp.com/v3/businesses/search?location=sydney&term=restaurant'

    req = requests.get(url,headers=headers)
    response = req.json()
    
    temp_dict = {'name': '','image_url' : '','rating': '','latitude':'','longitude': ''}
    toReturn = list()
    for x in response['businesses']:
        temp_dict = {'name': '','image_url' : '','rating': '','latitude':'','longitude': ''}
        temp_dict['name'] = x['name']
        temp_dict['image_url'] = x['image_url']
        temp_dict['rating'] = x['rating']
        temp_dict['latitude'] = x['coordinates']['latitude']
        temp_dict['longitude'] = x['coordinates']['longitude']

        toReturn.append(temp_dict)

    return dumps(toReturn)


@APP.route('/weather', methods=['GET'])
def weather():
    dattime = request.args.get('datetime')
    lat = float(request.args.get('latitude'))
    lon = float(request.args.get('longtitude'))

    url = 'http://api.openweathermap.org/data/2.5/forecast?lat={}&lon={}&appid=094385d28744303ab7695075f34baf94'.format(lat,lon)


    req = requests.get(url)
    response = req.json()

    toReturn = list()
    temp_dict = {'temp': '','description' : ''}
    for elem in response["list"]:
        if elem['dt'] == dattime:   
            temp_dict['temp'] = int(float(elem['main']['temp']) - 274.15)
            x = elem['weather'][0]
            temp_dict['description'] = x['description']

    return dumps(temp_dict)


# if __name__ == "__main__":
#    APP.run()
