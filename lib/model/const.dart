import 'package:flutter/material.dart';
class Constants{

  static String appName = "SEND★ME";

  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.red;
  static Color? darkAccent = Colors.red[400];
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color? ratingBG = Colors.yellow[600];

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );

  static Map<String,String> imageIndex = {
    "backgroundSplash" : "assets/Icons/ic_animated_bg.png",
    "riderSplash" : "assets/Icons/ic_get_start.png",
    "packageSplash" : "assets/Icons/package_splash.png",
    "foodSplash" : "assets/Icons/food_splash.png",
    "medicineSplash" : "assets/Icons/medicine_splash.png",
    "trashSplash" : "assets/Icons/trash_splash.png",
    "packageIntro" : "assets/Icons/package_intro.png",
    "foodIntro" : "assets/Icons/food_intro.png",
    "medicineIntro" : "assets/Icons/medicine_intro.png",
    "trashIntro" : "assets/Icons/trash_intro.png",
  };


}