import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/core/failure.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/providers/products_provider.dart';

class GetCategoriesUseCase extends BaseUseCase<NoParams, List<Category>> {
  final ProductsProvider provider = ProductsProvider();
  @override
  Future<Either<Failure, List<Category>>> call(NoParams input) =>
      provider.getCategories();
}
