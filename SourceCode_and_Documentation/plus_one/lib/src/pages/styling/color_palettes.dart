import 'dart:core';
import 'package:flutter/material.dart';

Color snow = Color(0xffFCF7F8);
Color lightGray = Color(0xffCED3DC);
Color persianGreen = Color(0xff1B998B);
Color orange = Color(0xffFC8400);
Color blackCoral = Color(0xff5B616A);


List<Color> plusOnePalette = [
  Color(0xffFCF7F8),
  Color(0xffCED3DC),
  Color(0xff1B998B),
  Color(0xffFC8400),
  Color(0xff5B616A)
];

LinearGradient verticalGradient(List<Color> palette){
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: palette,
  );
}

LinearGradient horizontalGradient(List<Color> palette){
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: palette,
  );
}