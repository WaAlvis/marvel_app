

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _prefs;

  static bool _isDarkMode = false;
  static String _searchedWord = '';

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }


  static String get searchedWord {
   return _prefs.getString('name')?? _searchedWord;
  }

  static set searchedWord(String value) {
    _searchedWord = value;
    _prefs.setString('name', value);
  }

}