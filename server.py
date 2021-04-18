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



# def get_events(token="WIMXDPIS3V2F74GY3G7V"):
#     # set headers with user token
#     header = {"Authorization": "Bearer {}".format(token)}
#     # hit API and parse response
#     request = requests.get("https://www.eventbriteapi.com/v3/users/me/events/", headers=headers)
#     response = request.json()
#     our_events = []
#     for event in response['events']:

# $.ajax({
#   type:"GET",
#   url:"https://app.ticketmaster.com/discovery/v2/events.json?size=1&apikey={apikey}",
#   async:true,
#   dataType: "json",
#   success: function(json) {
#               console.log(json);
#               // Parse the response.
#               // Do other things.
#            },
#   error: function(xhr, status, err) {
#               // This time, we do not end up here!
#            }
# });

#def func():
#    apikey = "QifuffoT98eP9eJcC08aMGfjvjb9DXGp"
#    req = request.get("https://app.ticketmaster.com/discovery/v2/events.json?startDateTime='19 september 2022'&apikey={apikey}")
#    response = req.json()
#    return response


@APP.route('/hello', methods=['GET'])
def hello():
    return "hello world"

@APP.route('/events', methods=['GET'])
def events():
    apikey = "7elxdku9GGG5k8j0Xm8KWdANDgecHMV0"
    req = requests.get("https://app.ticketmaster.com/discovery/v2/events.json?size=1&apikey={apikey}")
    return req
    response = req.json()
    return response

@APP.route('/event', methods=['GET'])
def event():
    req = requests.get("https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&locale=*&startDateTime=2021-04-20T22:38:00Z&city=Sydney&countryCode=AU&stateCode=NSW")
    response = req.json()
    our_events = []
    for event in response["_embedded"]["events"]:
        #for event2 in event["events"]:
        our_events.append(event["name"])
    return dumps(our_events)


#if __name__ == "__main__":
#    APP.run()










#GET /v3/users/me HTTP 1.1 Host: www.eventbriteapi.com Authorization: Bearer WIMXDPIS3V2F74GY3G7V
