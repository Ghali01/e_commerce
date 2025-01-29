import 'package:e_commerce/logic/data/models/product.dart';

abstract class ProductsListState {}

class ProductsListInitial extends ProductsListState {}

//loading the products
class ProductsListLoading extends ProductsListState {}

//loaded the products
class ProductsListLoaded extends ProductsListState {
  final List<Product> productsList;
  ProductsListLoaded(this.productsList);
}

//an error occurred while loading
class ProductsListError extends ProductsListState {
  final String message;

  ProductsListError(this.message);
}
