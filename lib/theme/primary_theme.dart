import 'package:flutter/material.dart';

abstract class PrimaryTheme {
  PrimaryTheme._();

  static ThemeData generateTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.lightBlue,
      brightness: Brightness.light,
      textTheme: const TextTheme(
          headline6: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      )),
      backgroundColor: Colors.white,
    );
  }
}
