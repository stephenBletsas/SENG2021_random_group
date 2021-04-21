import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Weather with ChangeNotifier {
  String temp = "-12";
  String desc = "";

  Future<void> getWeather(lat, long, dt) async {
    final url = 'http://0.0.0.0:5000/weather?lat=$lat&long=$long&datetime=$dt';

    try {
      final response = await http.get(url);

      final w = json.decode(response.body);
      temp = w['temp'].toString();
      desc = w['description'];
      print(w);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
