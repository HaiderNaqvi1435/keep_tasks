import 'package:flutter/material.dart';

class MyThemes {
  // bool isDark = Provider.of<TasksProvider>(context).isDark;
  static ThemeData myTheme(bool isDark, BuildContext context) {
    return ThemeData(
      // cardTheme: CardTheme(
      //   color: is
      // ),
      primarySwatch: Colors.red,
      drawerTheme: DrawerThemeData(
          backgroundColor: isDark ? Colors.black : Colors.red),
      primaryColor: isDark ? Colors.black : Colors.white,
      backgroundColor: isDark ? Colors.black : Color(0xffF1F5FB),
      indicatorColor: isDark ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      highlightColor: isDark ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDark ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDark ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      hintColor: isDark ? Color(0xff280C0B) : Color(0xffEECED3),

      cardColor: isDark ? Color(0xFF151515) : Colors.white,
      canvasColor: isDark ? Colors.black : Colors.grey[50],
      brightness: isDark ? Brightness.dark : Brightness.light,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.red),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: isDark ? Colors.black : Colors.white,
      ),

      //  isDarkTheme ? Colors.white : Colors.black,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDark ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }

  //  ThemeData(
  //       brightness: Brightness.light,
  //       // fontFamily: GoogleFonts.lato().fontFamily,
  //       colorScheme: const ColorScheme(
  //           brightness: Brightness.light,
  //           primary: const Color.fromARGB(255, 254, 76, 102),
  //           onPrimary: Colors.white,
  //           secondary: Colors.white,

  //           //old secondary  Color.fromARGB(255, 176, 190, 197),
  //           onSecondary: Colors.black,
  //           error: const Color.fromARGB(255, 195, 44, 33),
  //           onError: Colors.red,
  //           background: Colors.white,
  //           onBackground: Colors.black,
  //           surface: const Color.fromARGB(255, 224, 224, 224),
  //           onSurface: Colors.black),
  //     );
  // static ThemeData get MyDarkTheme => ThemeData(
  //       brightness: Brightness.dark,

  //       // fontFamily: GoogleFonts.lato().fontFamily,
  //     );
}
