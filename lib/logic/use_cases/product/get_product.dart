import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/logic/data/models/product.dart';
import 'package:e_commerce/logic/data/providers/products_provider.dart';

class GetProductUseCase extends BaseUseCase<int, Product> {
  final ProductsProvider provider = ProductsProvider();
  @override
  Future<Either<Failure, Product>> call(int input) =>
      provider.getProduct(input);
}
