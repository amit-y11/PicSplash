import 'package:flutter/material.dart';

class MyTheme {
  static Color accentColor = Colors.amber;

  static setAccentColor(Color accent) {
    accentColor = accent;
  }
  static final accent = Colors.amber;
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    canvasColor: Colors.white,
    primaryColor: Colors.white,
    accentColor: Colors.amber,
  );

  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black87,
      colorScheme: ColorScheme.dark(),
      canvasColor: Colors.black87,
      accentColor: Colors.amber);
}
