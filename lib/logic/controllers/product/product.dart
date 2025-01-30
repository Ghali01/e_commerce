import 'package:bloc/bloc.dart';

import 'package:e_commerce/logic/data/states/product/product.dart';
import 'package:e_commerce/logic/use_cases/product/get_product.dart';

class ProductBloc extends Cubit<ProductState> {
  final GetProductUseCase useCase = GetProductUseCase();
  final int id;
  ProductBloc(
    this.id,
  ) : super(ProductInitial());

  Future<void> load() async {
    emit(ProductLoading());
    final result = await useCase(id);

    //handle result
    result.fold(
        (l) => emit(ProductError(l.message)), (r) => emit(ProductLoaded(r)));
  }

  void setCounter(int d) => emit((state as ProductLoaded).setCounter(d));
}
