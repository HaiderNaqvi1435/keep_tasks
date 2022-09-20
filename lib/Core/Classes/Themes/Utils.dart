import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
class Utils {
  static TextStyle appName({Color? color, double? size}) {
    return TextStyle(
      fontSize: size ?? 22,
      fontWeight: FontWeight.bold,
    );
  }
  static TextStyle normalText({Color? color, double? size, bool bold = false}) {
    return TextStyle(
      fontSize: size ?? 16,
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
      fontSize: size ?? 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
  }
  static TextStyle logintext({
    bool bold = false,
    Color? color,
    double? size,
  }) {
    return TextStyle(
      fontFamily: GoogleFonts.roboto().fontFamily,
      fontSize: size ?? 14,
      fontWeight: bold ? FontWeight.w900 : FontWeight.normal,
    );
  }
  static InputDecoration myTextField(
      {String? label,
      IconData? iconData,
      String? hint,
      Color? color,
      VoidCallback? onPress}) {
    return InputDecoration(
      suffixIcon: iconData != null
          ? IconButton(onPressed: onPress, icon: Icon(iconData))
          : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      labelText: label,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 14),
      labelStyle: const TextStyle(fontSize: 14),
    );
  }
  static InputDecoration authField(
      {String? label, IconData? icondata, VoidCallback? onpress}) {
    return InputDecoration(
      suffixIcon: icondata != null
          ? IconButton(onPressed: onpress, icon: Icon(icondata))
          : null,
      isDense: true,
      label: Text(label!),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
