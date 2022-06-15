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
  primaryColor: appPurple,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: appPurple,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: appPurpleDark3),
  ),
);
ThemeData themeDark = ThemeData(
  primaryColor: appPurple,
  scaffoldBackgroundColor: appPurpleDark,
  appBarTheme: const AppBarTheme(
    backgroundColor: appPurple,
  ),
);
