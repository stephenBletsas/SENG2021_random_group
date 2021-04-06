import 'package:flutter/material.dart';
import './event.dart';
import './events.dart';
import './path.dart';

class Paths with ChangeNotifier {
  List<Path> _paths = [
    Path(
      id: 'P1',
      title: 'A Day At The Beach!',
      description: 'A Pleasant Day At The Beach With Your Friends!!',
      events: [
        Event(
          id: 'E1',
          title: 'Coogee Beach',
          description:
              "Coogee Beach is a great beach with calm surf and is family-friendly. The promenade area has restored historic buildings and nurtured parklands\.Most of the facilities are located at mid-beach with showers, change rooms and toilets near the Arden Street bus stop.Upmarket restaurants now jostle with fish and chip shops and an increasing number of boutiques.",
          imageUrl:
              'https://coogeebeach.crowneplaza.com/wp-content/uploads/2020/09/Ocean-Front-View-Coogee-Beach.jpg',
        ),
        Event(
          id: 'E2',
          title: 'Coogee Bay Hotel',
          description:
              "Across the street from Coogee Beach, this lively hotel in an airy building dating from 1863 is 10 km from both Darling Harbour and the Sydney Opera House, and 5 km from Bondi Beach.",
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSC4Yr9FAiZOa2jTalm5VyrVHVwnOnD19fDQ&usqp=CAU.jpg',
        ),
        Event(
          id: 'E3',
          title: 'Coogee Pavillion',
          description: "Nice Place ... lol",
          imageUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSC4Yr9FAiZOa2jTalm5VyrVHVwnOnD19fDQ&usqp=CAU.jpg',
        ),
      ],
      image:
          "https://coogeebeach.crowneplaza.com/wp-content/uploads/2020/09/Ocean-Front-View-Coogee-Beach.jpg",
    ),
    // Path(
    //     id: 'P2',
    //     title: 'Blue Mountains',
    //     description: 'Exploring the Blue Mountains',
    //     events: [
    //       Event(
    //         id: 'E4',
    //         title: title,
    //         description: description,
    //         imageUrl: imageUrl,
    //       )
    //     ]),
    // Path(
    //   id: 'P3',
    //   title: title,
    //   description: description,
    //   events: events,
    // ),
  ];

  List<Path> get paths {
    return [..._paths];
  }

  Path findById(String id) {
    return _paths.firstWhere((path) => path.id == id);
  }
}
