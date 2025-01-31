import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/logic/data/models/product.dart';
import 'package:e_commerce/logic/data/providers/products_provider.dart';

class AddProductUseCase extends BaseUseCase<Product, void> {
  final ProductsProvider provider = ProductsProvider();
  @override
  Future<Either<Failure, void>> call(Product input) =>
      provider.addProduct(input);
}
