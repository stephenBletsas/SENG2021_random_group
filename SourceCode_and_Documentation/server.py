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
    print(data)
    data2 = f'{data[:4]}-{data[5:7]}-{data[8:10]}T23:59:59Z'
    print(f'{data}    ||    {data2}')
    req = requests.get(f'https://app.ticketmaster.com/discovery/v2/events?apikey=7elxdku9GGG5k8j0Xm8KWdANDgecHMV0&locale=*&startDateTime={data}&endDateTime={data2}&city=Sydney&countryCode=AU&stateCode=NSW')
    response = req.json()
    our_events = []
    try:
        for event in response["_embedded"]["events"]:
            my_dict = dict()
            my_dict['name'] = event["name"]
            my_dict['lat'] = event["_embedded"]["venues"][0]["location"]["latitude"]
            my_dict['long'] = event["_embedded"]["venues"][0]["location"]["longitude"]
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
    
    lat = float(request.args.get('lat'))
    lon = float(request.args.get('long'))
    radius = '5000'

    headers = {"Authorization": "Bearer ogcfnTUH24f20GImeBgHY7r90WNlgPEQrQTIHXSKhq9L-nj1-nBvosyAyoJ9eLingqAqjd1tC8lJs0rzyESrzii4GLK2IrkrzpJZZdAWxFywUB98HzPWQ51hQlZ9YHYx"}
    url = 'https://api.yelp.com/v3/businesses/search?latitude={}&longitude={}&radius={}&term=restaurant&limit=50&sort_by=rating'.format(lat,lon,radius)
    print(url)
    req = requests.get(url,headers=headers)
    response = req.json()
    
    temp_dict = {'name': '','image_url' : '','rating': '','latitude':'','longitude': ''}
    toReturn = list()
    count = 0
    for x in response['businesses']:
        temp_dict = {'name': '','image_url' : '','rating': '','latitude':'','longitude': ''}
        temp_dict['name'] = x['name']
        temp_dict['image_url'] = x['image_url']
        temp_dict['rating'] = x['rating']
        temp_dict['latitude'] = x['coordinates']['latitude']
        temp_dict['longitude'] = x['coordinates']['longitude']

        toReturn.append(temp_dict)
        count = count + 1

    return dumps(toReturn)


@APP.route('/weather', methods=['GET'])
def weather():
    dattime = int(request.args.get('datetime'))
    #20210424
    lat = float(request.args.get('lat'))
    lon = float(request.args.get('long'))
    

    url = 'http://api.openweathermap.org/data/2.5/forecast?lat={}&lon={}&appid=094385d28744303ab7695075f34baf94'.format(lat,lon)


    req = requests.get(url)
    response = req.json()

    toReturn = list()
    temp_dict = {'temp': '','description' : ''}
    for elem in response["list"]:
        if int(elem['dt']) > dattime-10800 and int(elem['dt']) < dattime+10800:   
            temp_dict['temp'] = int(float(elem['main']['temp']) - 274.15)
            x = elem['weather'][0]
            temp_dict['description'] = x['description']

    return dumps(temp_dict)

@APP.route('/create-path', methods=['GET'])
def get_path():
    theme = request.args.get('theme')
    path1 = {
      'id': 'P2',
      'title': 'A Nice Evening Out!',
      'description': 'A Wonderful Dinner With Club Experience!!',
      'events': [
        {
          'id': 'E4',
          'title': 'Bel And Brio',
          'description':
              "Bel & Brio is a modern-day establishment showcasing eco-elegance and a luxuriously captivating ambience and seasonal Italian food and wine offerings, creating an exceptional and enchanting customer experience.",
          'imageUrl':
              'https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,g_auto:subject,q_auto,f_auto/restaurant/777331f9-a4e3-4bc2-81b0-af8e576eac1e/17f377f4-88ba-4f87-adc4-fd21b366e89d.jpg',
          'lat': -33.865356,
          'long': 151.201862,
        },
        {
          'id': 'E5',
          'title': 'Little Felix Bar',
          'description':
              "Tucked alongside Felix Restaurant in Ash Street, you’ll find Little Felix – a French-style cocktail bar with a moody interior and bartenders who know exactly how you like your drink.",
          'imageUrl':
              'https://s3-ap-southeast-2.amazonaws.com/production.assets.merivale.com.au/wp-content/uploads/2019/11/01095321/Little_Felix_VenuePageTile_640x416px.jpg',
          'lat': -33.866461,
          'long': 151.207743
        },
        {
          'id': 'E3',
          'title': 'Ivy Night Club',
          'description': "Dance the night away at ivy pool club in the heart of the CBD. Home to Sydney's best parties, featuring live music, DJs, exceptional entertainment & more.",
          'imageUrl':
              'https://musicfeeds.com.au/assets/uploads/ea15d52f2a47e5a4b37c8ba11528486c.jpg',
          'lat': -33.865899,
          'long': 151.207715,
        }
      ],
      'image':
          "https://res.cloudinary.com/tf-lab/image/upload/w_600,h_337,c_fill,g_auto:subject,q_auto,f_auto/restaurant/777331f9-a4e3-4bc2-81b0-af8e576eac1e/17f377f4-88ba-4f87-adc4-fd21b366e89d.jpg",
    }

    path2 = {
        'id': 'P3',
        'title': 'Sydney Opera House Tour!',
        'description': 'A walk with a beautiful scenic view!',
      'events': [
        {
          'id': 'E7',
          'title': 'Sydney Opera House',
          'description':
              "The Sydney Opera house is a multi venue performing centre located at Sydney Harbour in Sydney.The Sydney Opera House is one of the most photographed buildings in the world,known for its unique use of a series of gleaming white sail-shaped shells as its roof structure.",
          'imageUrl':
            'https://media2.trover.com/T/53e5403bd6bdd47d32000036/fixedw.jpg',
          'lat': -33.86568,
          'long': 151.2153,
        },
        {
          'id': 'E8',
          'title': 'Sydney Harbour Bridge',
          'description':
              "The Sydney Harbour Bridge is an iconic landmark spanning one of the finest natural harbours known to mankind. Opened in 1932, the bridge is fondly nicknamed the Coathanger by Sydneysiders. You can walk and cycle across the bridge or climb to the top for stunning views.",
          'imageUrl':
              'https://upload.wikimedia.org/wikipedia/commons/a/a8/Sydney_harbour_bridge_new_south_wales.jpg',
          'lat': -33.852294,
          'long': 151.210735
        },
        {
          'id': 'E9',
          'title': 'Dinner alongside Darling Harbour',
          'description': "Lavish dinner at the famous Hard Rock Cafe alongside Darling Harbour.Enjoy the spectacular view!",
          'imageUrl':
             'https://images.otstatic.com/prod/25797386/1/large.jpg',
          'lat': -33.8669,
          'long': 151.2008,
        }
      ],
      'image':
          'https://media2.trover.com/T/53e5403bd6bdd47d32000036/fixedw.jpg'
    }

    if(theme=="CITY"):
        return dumps(path1)
    elif (theme=="TOURIST ATTRACTION"):
        return dumps(path2)





    return dumps(path)



if __name__ == "__main__":
   APP.run(host='0.0.0.0', port=5000)