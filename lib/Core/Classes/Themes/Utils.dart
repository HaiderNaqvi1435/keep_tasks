import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';

class Utils {
  static TextStyle appName({Color? color, double? size}) {
    return TextStyle(
      color: color ?? Colors.white,
      fontSize: size ?? 22,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle normalText({Color? color, double? size, bool bold = false}) {
    return TextStyle(
      color: color ?? Colors.white,
      fontSize: size ?? 16,
      // fontWeight: FontWeight.bold,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
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

  static InputDecoration MytextField(
      {String? Label,
      IconData? iconData,
      String? hint,
      Color? color,
      VoidCallback? onPress}) {
    return InputDecoration(
      suffixIcon: iconData != null
          ? IconButton(onPressed: onPress, icon: Icon(iconData))
          : null,
      contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      labelText: Label,
      hintText: hint,
    
      filled: true,
      fillColor: color ?? MyThemes.MyTheme.colorScheme.onPrimary,
      // prefixIcon: Icon(iconData),
      hintStyle: TextStyle(fontSize: 14),
      labelStyle: TextStyle(fontSize: 14),

      // enabledBorder: OutlineInputBorder(
      //   borderSide: const BorderSide(color: Colors.transparent),
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      // focusedBorder: OutlineInputBorder(
      //   borderSide: BorderSide(color: Colors.transparent),
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      // errorBorder: OutlineInputBorder(
      //   borderSide: const BorderSide(color: Colors.red),
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      // focusedErrorBorder: OutlineInputBorder(
      //   borderSide: const BorderSide(color: Colors.red),
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
    );
  }
}
