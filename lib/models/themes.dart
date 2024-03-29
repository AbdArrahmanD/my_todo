import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/theme_controller.dart';

ThemeController controller = Get.put(ThemeController());

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    primaryColor: primaryClr,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

TextStyle headingStyle({Color? color, double? size, FontWeight? fontWeight}) =>
    GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size ?? 24,
        fontWeight: fontWeight ?? FontWeight.bold,
        // ignore: prefer_if_null_operators
        color: color != null
            ? color
            : controller.theme.value == ThemeMode.dark
                ? Colors.white
                : Colors.black,
      ),
    );

TextStyle subHeadingStyle(
        {Color? color, double? size, FontWeight? fontWeight}) =>
    GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size ?? 20,
        fontWeight: fontWeight ?? FontWeight.bold,
        // ignore: prefer_if_null_operators
        color: color != null
            ? color
            : controller.theme.value == ThemeMode.dark
                ? Colors.white
                : Colors.black,
      ),
    );

TextStyle titleStyle({Color? color, double? size, FontWeight? fontWeight}) =>
    GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size ?? 18,
        fontWeight: fontWeight ?? FontWeight.bold,
        // ignore: prefer_if_null_operators
        color: color != null
            ? color
            : controller.theme.value == ThemeMode.dark
                ? Colors.white
                : Colors.black,
      ),
    );

TextStyle subTitleStyle({Color? color, double? size, FontWeight? fontWeight}) =>
    GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size ?? 16,
        fontWeight: fontWeight ?? FontWeight.bold,
        // ignore: prefer_if_null_operators
        color: color != null
            ? color
            : controller.theme.value == ThemeMode.dark
                ? Colors.white
                : Colors.black,
      ),
    );

TextStyle bodyStyle({Color? color, double? size, FontWeight? fontWeight}) =>
    GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size ?? 14,
        fontWeight: fontWeight ?? FontWeight.bold,
        // ignore: prefer_if_null_operators
        color: color != null
            ? color
            : controller.theme.value == ThemeMode.dark
                ? Colors.white
                : Colors.black,
      ),
    );

TextStyle bodyStyle2({Color? color, double? size, FontWeight? fontWeight}) =>
    GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: size ?? 14,
        fontWeight: fontWeight ?? FontWeight.bold,
        // ignore: prefer_if_null_operators
        color: color != null
            ? color
            : controller.theme.value == ThemeMode.dark
                ? Colors.grey[200]
                : Colors.black,
      ),
    );

Color getColor({
  required Color lightColor,
  required Color darkColor,
}) =>
    controller.theme.value == ThemeMode.dark ? darkColor : lightColor;
