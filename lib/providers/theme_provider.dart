import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  var primaryColor = Colors.pink;
  var accentColor = Colors.amber;

  var tm = ThemeMode.system;
  String themeText = "sys";

  onChanged(newColor, whichColor) async {
    whichColor == 1
        ? primaryColor = _setToMaterialColor(newColor.hashCode)
        : accentColor = _setToMaterialColor(newColor.hashCode);

    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("primaryColor", primaryColor.value);
    prefs.setInt("accentColor", accentColor.value);
  }

  MaterialColor _setToMaterialColor(colorVal) {
    // as in primarySwatch & accentColor in ThemeData accepts only MaterialColor not only Color like White & Black & .....
    // so we need to change returnedColor from Color to MaterialColor to accept in primarySwatch & accentColor
    return MaterialColor(
      colorVal,
      <int, Color>{
        50: Color(0xFFFCE4EC),
        100: Color(0xFFF8BBD0),
        200: Color(0xFFF48FB1),
        300: Color(0xFFF06292),
        400: Color(0xFFEC407A),
        500: Color(colorVal),
        600: Color(0xFFD81B60),
        700: Color(0xFFC2185B),
        800: Color(0xFFAD1457),
        900: Color(0xFF880E4F),
      },
    );
  }

  void themeModeChange(newThemeVal) async {
    tm = newThemeVal;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("themeMode", themeText);
  }

  _getThemeText(ThemeMode tm) {
    if (tm == ThemeMode.system)
      themeText = "sys";
    else if (tm == ThemeMode.dark)
      themeText = "dark";
    else if (tm == ThemeMode.light) themeText = "light";
  }

  getThemeDataFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString("themeMode") ?? "sys";
    if (themeText == "sys")
      tm = ThemeMode.system;
    else if (themeText == "dark")
      tm = ThemeMode.dark;
    else if (themeText == "light") tm = ThemeMode.light;

    primaryColor =
        _setToMaterialColor(prefs.getInt("primaryColor") ?? 0xFFE91E63);
    accentColor =
        _setToMaterialColor(prefs.getInt("accentColor") ?? 0xFFFFC107);

    notifyListeners();
  }
}
