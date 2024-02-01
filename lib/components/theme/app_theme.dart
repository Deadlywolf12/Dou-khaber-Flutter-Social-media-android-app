import 'package:cinepopapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white54, fontSize: 18),
      bodyMedium: TextStyle(
          color: Colors.white54, fontSize: 18, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(
        color: Colors.white54,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
      displaySmall: TextStyle(
        color: Colors.white54,
        fontSize: 15,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      )),
  appBarTheme: const AppBarTheme(
    backgroundColor: Appcolors.background,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    background: Appcolors.background,
    primary: Appcolors.primary,
    onBackground: Appcolors.background,
    secondary: Appcolors.black,
    primaryContainer: Colors.white,
    onPrimaryContainer: Colors.black,
    shadow: Colors.black.withOpacity(0.3),
    surface: Appcolors.primary,
    outline: Appcolors.white,
  ),
);

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
        bodySmall: TextStyle(color: Colors.black54, fontSize: 18),
        bodyMedium: TextStyle(
            color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold),
        labelSmall: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        labelMedium: TextStyle(
          color: Colors.black54,
          fontSize: 18,
        ),
        displaySmall: TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
        headlineMedium: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        )),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: Appcolors.background,
        secondary: Appcolors.background,
        primaryContainer: Appcolors.background,
        onPrimaryContainer: Colors.white,
        shadow: Colors.white.withOpacity(0.3),
        surface: Appcolors.background,
        outline: Appcolors.primary));
