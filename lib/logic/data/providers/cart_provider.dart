import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/core/helpers_functions.dart';
import 'package:e_commerce/logic/data/models/cart_item.dart';
import 'package:e_commerce/logic/data/repositories/cart_repository.dart';
import 'package:e_commerce/logic/data/repositories/products_repository.dart';

class CartProvider {
  final CartRepository cartRepository = CartRepository();
  final ProductsRepository productsRepository = ProductsRepository();
  Future<Either<Failure, void>> addCartItem(CartItem item) async {
    try {
      //insert cart item to database
      cartRepository.insertCartItem(item.toMap());
      return const Right(null);
    } catch (e) {
      return const Left(Failure(message: 'An error', code: 100));
    }
  }
  //get cart items

  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      // get cart items from database
      final cartItems = await cartRepository.getCartItems();
      final data = cartItems.map((e) => CartItem.fromMap(e)).toList();
      return Right(data);
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(message: 'An error', code: 100));
    }
  }

  //delete cart item
  Future<Either<Failure, void>> deleteCartItem(int id) async {
    try {
      //delete cart item from database
      cartRepository.deleteCartItem(id);
      return const Right(null);
    } catch (e) {
      return const Left(Failure(message: 'An error', code: 100));
    }
  }

  Future<Either<Failure, void>> checkoutCard() async {
    try {
      // get cart items from database
      final cartItems = await cartRepository.getCartItems();
      //convert to api json
      final rawItems =
          cartItems.map((e) => CartItem.fromMap(e).toApiMap()).toList();

      await productsRepository.addCart(rawItems);

      await cartRepository.clearCart();
      return const Right(null);
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(message: 'An error', code: 100));
    }
  }
}
