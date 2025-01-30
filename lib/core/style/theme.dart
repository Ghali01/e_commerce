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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff1f293d)),
      ),
      scaffoldBackgroundColor: Color(0xfff5f5f5),
      textTheme: TextTheme(
          displaySmall: TextStyle(fontSize: 26),
          titleLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54),
          bodySmall: const TextStyle(fontSize: 14, color: Colors.grey)),
    );
