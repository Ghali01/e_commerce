import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/logic/data/models/cart_item.dart';
import 'package:e_commerce/logic/data/providers/cart_provider.dart';

class GetCartUseCase extends BaseUseCase<NoParams, List<CartItem>> {
  final CartProvider provider = CartProvider();
  @override
  Future<Either<Failure, List<CartItem>>> call(NoParams input) =>
      provider.getCartItems();
}
