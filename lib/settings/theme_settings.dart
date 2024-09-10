import 'package:flutter/material.dart';

class ThemeSettings {
  static ThemeData lightTheme() {
    final theme = ThemeData.light();
    return theme.copyWith(scaffoldBackgroundColor: Colors.amber);
  }

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return theme.copyWith(scaffoldBackgroundColor: Colors.grey);
  }

  static ThemeData warmTheme() {
    final theme = ThemeData.light();
    return theme.copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 146, 15, 143));
  }
}
