import 'package:flutter/material.dart';

class ThemeState extends ValueNotifier<ThemeMode> {
  ThemeState() : super(ThemeMode.light);

  void toggleTheme() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeState = ThemeState();
