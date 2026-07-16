import 'package:flutter/material.dart';
import '../services/shared_pref_service.dart';

class ThemeProvider extends ChangeNotifier {
  final SharedPrefService _prefs = SharedPrefService();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    loadTheme();
  }

  Future<void> loadTheme() async {
    String theme = await _prefs.getTheme();

    switch (theme) {
      case "light":
        _themeMode = ThemeMode.light;
        break;

      case "dark":
        _themeMode = ThemeMode.dark;
        break;

      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setTheme(ThemeMode mode) async {
    _themeMode = mode;

    if (mode == ThemeMode.light) {
      await _prefs.saveTheme("light");
    } else if (mode == ThemeMode.dark) {
      await _prefs.saveTheme("dark");
    } else {
      await _prefs.saveTheme("system");
    }

    notifyListeners();
  }
}