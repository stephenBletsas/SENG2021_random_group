import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './event.dart';
import './path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'event.dart';

class Paths with ChangeNotifier {
  List<Path> _paths = [
    Path(
      id: 'P1',
      title: 'A Day At The Beach!',
      description: 'A Pleasant Day At The Beach With Your Friends!!',
      dateTime: DateTime(2021, 4, 21, 9, 30),
      events: [
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
      ],
      image:
          "https://coogeebeach.crowneplaza.com/wp-content/uploads/2020/09/Ocean-Front-View-Coogee-Beach.jpg",
    ),
  ];

  List<Path> get paths {
   return [..._paths];
  }

  Path findById(String id) {
    return _paths.firstWhere((path) => path.id == id);
  }

  Future<Path> addPath(String theme, DateTime date, DateTime time) async {
    Path newPath;
    final url = "http://0.0.0.0:5000/create-path?theme=$theme";
    try {
      final response = await http.get(url);

      final p = json.decode(response.body);
      print(p);
      List<Event> _events = [];

      for (Map e in p['events']) {
        Event newEvent = Event(
          id: e['id'],
          title: e['title'],
          description: e['description'],
          imageUrl: e['imageUrl'],
          lat: e['lat'],
          long: e['long'],
        );
        _events.add(newEvent);
      }
      DateTime dt =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);

      newPath = Path(
        events: _events,
        id: p['id'],
        description: p['description'],
        title: p['title'],
        image: p['image'],
        dateTime: dt,
      );
      _paths.add(newPath);
      notifyListeners();
    } catch (error) {
      print("you are getting an error");
      print(error);
    }

    return newPath;
  }

  List<Path> getDonePaths() {
    List<Path> result = [];

    for (Path p in _paths) {
      if (p.done == true) {
        result.add(p);
      }
    }

    return result;
  }

  List<Path> getSelectedPaths() {
    List<Path> result = [];
    for (Path p in _paths) {
      if (p.isSelected == true) {
        result.add(p);
      }
    }
    return result;
  }
}
