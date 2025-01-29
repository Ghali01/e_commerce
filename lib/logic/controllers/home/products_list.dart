import 'package:bloc/bloc.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/states/home/products_list.dart';
import 'package:e_commerce/logic/use_cases/home/get_products.dart';

class ProductsListBloc extends Cubit<ProductsListState> {
  final GetProductsUseCase useCase = GetProductsUseCase();
  final Category category;
  ProductsListBloc(this.category) : super(ProductsListInitial());

  Future<void> load() async {
    emit(ProductsListLoading());
    final result = await useCase(category);
    result.fold((l) => emit(ProductsListError(l.message)),
        (r) => emit(ProductsListLoaded(r)));
  }
}
