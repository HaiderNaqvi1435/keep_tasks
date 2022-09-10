import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static TextStyle appName() {
    return TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle normalText({
    Color? color,
    double? size,
  }) {
    return TextStyle(
      color: color ?? Colors.white,
      fontSize: size ?? 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle metaText({
    bool bold = false,
    Color? color,
    double? size,
  }) {
    return TextStyle(
      fontFamily: GoogleFonts.exo2().fontFamily,
      color: color ?? Colors.white,
      fontSize: size ?? 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }
}
