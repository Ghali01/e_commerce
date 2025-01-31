import 'package:e_commerce/core/style/colors.dart';
import 'package:flutter/material.dart';

appTheme() => ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      inversePrimary: AppColors.inversePrimary,
    ),
    appBarTheme: const AppBarTheme(
      foregroundColor: Color(0xff1f293d),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1f293d)),
    ),
    scaffoldBackgroundColor: const Color(0xfff5f5f5),
    textTheme: const TextTheme(
        displaySmall: TextStyle(fontSize: 26),
        titleLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54),
        bodySmall: TextStyle(fontSize: 14, color: Colors.grey)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.primary),
        foregroundColor: WidgetStateProperty.all(AppColors.onPrimary),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    ));
