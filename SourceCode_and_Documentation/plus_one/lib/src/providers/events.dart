import 'package:flutter/material.dart';
import './event.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventsList with ChangeNotifier {
  List<Event> _newEvents = [];
  List<Event> _events = [
    Event(
      id: 'E1',
      title: 'Coogee Beach',
      description:
          "Coogee Beach is a great beach with calm surf and is family-friendly. The promenade area has restored historic buildings and nurtured parklands\.Most of the facilities are located at mid-beach with showers, change rooms and toilets near the Arden Street bus stop.Upmarket restaurants now jostle with fish and chip shops and an increasing number of boutiques.",
      imageUrl:
          'https://coogeebeach.crowneplaza.com/wp-content/uploads/2020/09/Ocean-Front-View-Coogee-Beach.jpg',
      lat: -33.920426,
      long: 151.258217,
    ),
    Event(
      id: 'E2',
      title: 'Coogee Bay Hotel',
      description:
          "Across the street from Coogee Beach, this lively hotel in an airy building dating from 1863 is 10 km from both Darling Harbour and the Sydney Opera House, and 5 km from Bondi Beach.",
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSC4Yr9FAiZOa2jTalm5VyrVHVwnOnD19fDQ&usqp=CAU.jpg',
      lat: -33.92107,
      long: 151.25633,
    ),
    Event(
      id: 'E3',
      title: 'Coogee Pavillion',
      description: "Nice Place ... lol",
      imageUrl:
          'https://s3-ap-southeast-2.amazonaws.com/production.assets.merivale.com.au/wp-content/uploads/2017/04/10153134/coogeepav_gallery3-11.jpg',
      lat: -33.91871,
      long: 151.25828,
    ),
  ];

  List<Event> get events {
    return [..._events];
  }

  List<Event> get newEvents {
    // print(_newEvents);
    return [..._newEvents];
  }

  Future<void> getCEvents(DateTime dt) async {
    // List<Event> result = [];
    // String fdt = DateFormat('yyyy-MM-ddTHH:mm:00Z').format(dt);

    String fdt = dt.toUtc().toIso8601String();

    print(fdt);
    final url = 'http://0.0.0.0:5000/event?datetime=2021-04-24T09:00:00Z';

    try {
      final response = await http.get(url);
      final l = json.decode(response.body);

      for (Map e in l) {
        double lat = double.parse(e['lat']);
        double long = double.parse(e['long']);

        Event event = Event(
          id: DateTime.now().toString(),
          title: e['name'],
          description: e['description'],
          imageUrl: e['imageUrl'],
          lat: lat,
          long: long,
        );
        _newEvents.add(event);
        print(_newEvents);
      }
    } catch (error) {
      print(error);
    }
  }
}
//  [{name: Handa Opera on Sydney Harbour - La Traviata, lat: -33.869579, long: 151.210004, image: https://s1.ticketm.net/dam/a/d86/9c4318fc-caba-4483-a80f-164f7f824d86_1391001_CUSTOM.jpg, datetime: 2021-04-21T09:30:00Z, description: Gates open 2 hours prior to performance time.}]
