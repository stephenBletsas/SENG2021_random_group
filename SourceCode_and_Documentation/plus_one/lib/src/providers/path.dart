import 'package:flutter/material.dart';

class Path with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String image;
  final List events;

  Path({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.events,
    @required this.image,
  });
}
