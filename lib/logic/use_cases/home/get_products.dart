import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/models/product.dart';
import 'package:e_commerce/logic/data/providers/products_provider.dart';

class GetProductsUseCase extends BaseUseCase<Category, List<Product>> {
  final ProductsProvider provider = ProductsProvider();
  @override
  Future<Either<Failure, List<Product>>> call(Category category) {
    if (category.name == 'All') {
      return provider.getAllProducts();
    }
    return provider.getCategoryProducts(category);
  }
}
