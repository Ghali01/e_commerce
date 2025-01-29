import 'package:e_commerce/core/routes.dart';
import 'package:e_commerce/core/style/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.home,
      theme: appTheme(),
    );
  }
}
