import 'package:flutter/material.dart';

import 'Utils.dart';

class MyThemes {
  static ThemeData myTheme(bool isDark, BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: Color.fromARGB(255, 62, 70, 175),
        onPrimary: isDark ? Colors.white : Colors.black,
        secondary: Color.fromARGB(255, 62, 70, 175),
        onSecondary: isDark ? Colors.black : Colors.white,
        error: Colors.red,
        onError: Colors.red,
        background: isDark ? Colors.black : Color(0xffF1F5FB),
        onBackground: isDark ? Colors.white : Color(0xFF151515),
        surface: isDark ? Color(0xFF151515) : Colors.white,
        onSurface: isDark ? Colors.white : Color(0xFF151515),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: isDark
            ? Color.fromARGB(255, 55, 55, 55)
            : Color.fromARGB(255, 62, 70, 175),
      ),
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDark ? Colors.black : Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? null : Color.fromARGB(255, 62, 70, 175),
        titleTextStyle: Utils.metaText(size: 18),
        foregroundColor: Colors.white,
        elevation: 0.0,
      ),
    );
  }
}
