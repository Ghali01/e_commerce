import 'package:e_commerce/core/style/colors.dart';
import 'package:flutter/material.dart';

appTheme() => ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      inversePrimary: AppColors.inversePrimary,
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: Color(0xff1f293d),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1f293d)),
    ),
    scaffoldBackgroundColor: Color(0xfff5f5f5));
