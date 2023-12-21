import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static TextStyle textfancyheader = GoogleFonts.merriweather(
      fontSize: 40, color: const Color.fromARGB(149, 83, 81, 81));
  static TextStyle textfancyheader2 = GoogleFonts.merriweather(
      fontSize: 25,
      color: const Color.fromARGB(147, 212, 25, 25),
      fontWeight: FontWeight.w900);
  static TextStyle text_error = const TextStyle(
      fontSize: 20, color: Colors.red, fontStyle: FontStyle.italic);
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
  static Color mainColor = const Color.fromARGB(255, 101, 103, 204);
  static Color backgroundColor = const Color.fromARGB(255, 164, 218, 253);
  static TextStyle textbodyw = const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 16,
      fontWeight: FontWeight.bold);
  static TextStyle textbodyfocusw = const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255),
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('yyyy/MM/dd');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}
