import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/logic/data/models/cart_item.dart';
import 'package:e_commerce/logic/data/models/product.dart';
import 'package:e_commerce/logic/data/providers/cart_provider.dart';

class AddToCartParams {
  final int quantity;
  final Product product;
  AddToCartParams({
    required this.quantity,
    required this.product,
  });
}

class AddToCartUseCase extends BaseUseCase<AddToCartParams, void> {
  final CartProvider provider = CartProvider();
  @override
  Future<Either<Failure, void>> call(AddToCartParams input) {
    final CartItem cartItem =
        CartItem.fromProduct(input.product, input.quantity);
    return provider.addCartItem(cartItem);
  }
}
