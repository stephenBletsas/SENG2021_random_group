import 'package:flutter/material.dart';
import '../providers/event.dart';

class Path with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String image;
  final List<Event> events;
  final DateTime dateTime;
  bool done = false;
  bool isSelected = false;

  Path({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.events,
    @required this.image,
    @required this.dateTime,
  });

  void donePath() {
    done = true;
    notifyListeners();
  }

  void doPath() {
    isSelected = true;
    notifyListeners();
  }
}
