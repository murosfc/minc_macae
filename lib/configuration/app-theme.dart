import 'package:flutter/material.dart';

class AppTheme {
  bool _isDarkTheme = false;
  final ThemeData _darkTheme = ThemeData.dark();
  final ThemeData _lightTheme = ThemeData.light();

  AppTheme() {}

  ThemeData getTheme() {
    return _isDarkTheme ? _darkTheme : _lightTheme;
  }

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
  }

  get isDarkTheme => _isDarkTheme;
}
