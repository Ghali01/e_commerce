import 'package:e_commerce/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return null;
    }
  }
}
