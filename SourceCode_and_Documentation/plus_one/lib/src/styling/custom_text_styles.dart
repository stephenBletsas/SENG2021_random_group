import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle buildLogoTextStyle(double fontSize) {
  return GoogleFonts.lobster(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: Colors.white,
  ));
}

//alt font : notoSans

TextStyle buildRobotoTextStyle(double fontSize, Color color) {
  return GoogleFonts.raleway(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: color,
  ));
}

TextStyle buildBoldRobotoText(double fontSize, Color color) {
  return GoogleFonts.raleway(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle buildCrimsonProTextStyle(double fontSize) {
  return GoogleFonts.crimsonPro(
      textStyle: TextStyle(
    fontSize: fontSize,
    color: Colors.black,
  ));
}
