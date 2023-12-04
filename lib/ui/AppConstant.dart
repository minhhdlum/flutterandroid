import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant {
  static TextStyle textfancyheader = GoogleFonts.merriweather(
      fontSize: 40, color: Color.fromARGB(149, 83, 81, 81));
  static TextStyle text_error = const TextStyle(
      fontSize: 16, color: Colors.red, fontStyle: FontStyle.italic);
  static TextStyle textlink = const TextStyle(
      color: Color.fromARGB(255, 179, 140, 229),
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static TextStyle textbody = const TextStyle(
      color: Color.fromARGB(255, 245, 135, 135),
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static TextStyle textbodyfocus = const TextStyle(
      color: Color.fromARGB(255, 247, 59, 106),
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static TextStyle textlogo = GoogleFonts.lato(
      fontSize: 30,
      color: const Color.fromARGB(255, 101, 209, 104),
      fontWeight: FontWeight.bold);
  static Color mainColor = Color.fromARGB(255, 247, 207, 231);
  static Color backgroundColor = Color.fromARGB(255, 250, 250, 250);
}
