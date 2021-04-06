import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Event with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Event({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
  });
}
