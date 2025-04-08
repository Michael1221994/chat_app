import 'package:flutter/material.dart';
import 'package:minimal_chat_app/themes/dark_mode.dart';
import 'package:minimal_chat_app/themes/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkmode;

  set themeData (ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if(_themeData == lightmode) _themeData = darkmode;
    else _themeData = lightmode;
    notifyListeners();
  }
}