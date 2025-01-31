import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/core/helpers_functions.dart';
import 'package:e_commerce/logic/data/models/cart_item.dart';
import 'package:e_commerce/logic/data/repositories/cart_repository.dart';
import 'package:e_commerce/logic/data/repositories/products_repository.dart';

class CartProvider {
  final CartRepository cartRepository = CartRepository();
  final ProductsRepository productsRepository = ProductsRepository();

  //add cart item to the storage
  Future<Either<Failure, void>> addCartItem(CartItem item) async {
    try {
      //insert cart item to storage
      cartRepository.insertCartItem(item.toMap());
      return const Right(null);
    } catch (e) {
      return const Left(Failure(message: 'An error', code: 100));
    }
  }

  ///get cart items
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      // get cart items from storage
      final cartItems = await cartRepository.getCartItems();
      final data = cartItems.map((e) => CartItem.fromMap(e)).toList();
      return Right(data);
    } catch (e) {
      debugPrint(e);
      return const Left(Failure(message: 'An error', code: 100));
    }
  }

  ///delete cart item
  Future<Either<Failure, void>> deleteCartItem(int id) async {
    try {
      //delete cart item from storage
      cartRepository.deleteCartItem(id);
      return const Right(null);
    } catch (e) {
      return const Left(Failure(message: 'An error', code: 100));
    }
  }

  /// Processes the checkout of the cart by retrieving cart items from the
  /// storage, converting them to the required API format, sending them
  /// to the server, and finally clearing the cart items from the storage.
  ///
  /// Returns a [Right] if the checkout process is successful, otherwise
  /// returns a [Left] containing a [Failure] with an error message and code.

  Future<Either<Failure, void>> checkoutCard() async {
    try {
      // get cart items from storage
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
