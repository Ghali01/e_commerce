import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/logic/data/providers/cart_provider.dart';

class DeleteCartItemUseCase extends BaseUseCase<int, void> {
  final CartProvider provider = CartProvider();
  @override
  Future<Either<Failure, void>> call(int input) =>
      provider.deleteCartItem(input);
}
