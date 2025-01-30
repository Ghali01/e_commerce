import 'package:e_commerce/presentation/screens/home/home.dart';
import 'package:e_commerce/presentation/screens/product/product.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const home = '/';
  static const product = '/product';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case product:
        final args = settings.arguments as ProductArgs;
        return MaterialPageRoute(
            builder: (_) => ProductScreen(
                  args: args,
                ));
      default:
        return null;
    }
  }
}
