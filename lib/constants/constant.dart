import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color(0xFF1E0771);
const appWhite = Color(0xFFFAF8FC);
const appPurpleDark1 = Color(0xFF2E0D8A);
const appPurpleDark2 = Color(0xFF9345F2);
const appPurpleDark3 = Color(0xFF260F68);
const appPurpleLight = Color(0xFFB9A2D8);
const appOrange = Color(0xFFE6704A);

ThemeData themeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: appPurple,
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: appPurpleDark,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: appPurple,
    elevation: 4,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: appPurpleDark3),
    bodyText2: TextStyle(color: appPurpleDark3),
  ),
  listTileTheme: const ListTileThemeData(
    textColor: appPurpleDark3,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: appPurpleDark,
    unselectedLabelColor: appPurpleLight,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appPurpleDark,
        ),
      ),
    ),
  ),
);

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: appPurple,
  scaffoldBackgroundColor: appPurpleDark,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: appWhite,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: appPurpleDark,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: appWhite),
    bodyText2: TextStyle(color: appWhite),
  ),
  listTileTheme: const ListTileThemeData(
    textColor: appWhite,
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: appWhite,
    unselectedLabelColor: appPurpleLight,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: appWhite,
        ),
      ),
    ),
  ),
);
