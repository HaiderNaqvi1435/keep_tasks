import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemes {
  static ThemeData get MyTheme => ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: const Color.fromARGB(255, 254, 76, 102),
            onPrimary: Colors.white,
            secondary: Colors.white,

            //old secondary  Color.fromARGB(255, 176, 190, 197),
            onSecondary: Colors.black,
            error: const Color.fromARGB(255, 195, 44, 33),
            onError: Colors.red,
            background: const Color.fromARGB(255, 236, 239, 241),
            onBackground: Colors.black,
            surface: const Color.fromARGB(255, 224, 224, 224),
            onSurface: Colors.black),
      );
}
