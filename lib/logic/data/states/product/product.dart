import 'package:e_commerce/logic/data/models/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;
  final int cartCount;

  ProductLoaded(this.product, {this.cartCount = 1});

  ProductLoaded setCounter(int d) =>
      ProductLoaded(product, cartCount: cartCount + d);
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductAddedToCart extends ProductLoaded {
  ProductAddedToCart(super.product, int cartCount)
      : super(cartCount: cartCount);
}
