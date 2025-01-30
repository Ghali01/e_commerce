import 'package:e_commerce/logic/data/models/cart_item.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded(this.items);
}

class CartLoadError extends CartState {
  final String message;

  CartLoadError(this.message);
}

class CartCheckoutError extends CartLoaded {
  final String message;
  CartCheckoutError(this.message, super.items);
}

class CartCheckoutLoading extends CartLoaded {
  CartCheckoutLoading(super.items);
}

class CartCheckoutSuccess extends CartState {}
