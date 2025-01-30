import 'package:bloc/bloc.dart';

import 'package:e_commerce/logic/data/states/product/product.dart';
import 'package:e_commerce/logic/use_cases/product/add_to_cart.dart';
import 'package:e_commerce/logic/use_cases/product/get_product.dart';

class ProductBloc extends Cubit<ProductState> {
  final GetProductUseCase useCase = GetProductUseCase();
  final AddToCartUseCase addToCartUseCase = AddToCartUseCase();
  final int id;
  ProductBloc(
    this.id,
  ) : super(ProductInitial());

  //load product data
  Future<void> load() async {
    emit(ProductLoading());
    final result = await useCase(id);

    //handle result
    result.fold(
        (l) => emit(ProductError(l.message)), (r) => emit(ProductLoaded(r)));
  }

  void setCounter(int d) {
    final s = (state as ProductLoaded);
    //counter can't be less then 1
    if (!(d == -1 && s.cartCount == 1)) {
      emit(s.setCounter(d));
    }
  }

  //add to cart
  Future<void> addToCart() async {
    final s = (state as ProductLoaded);
    final result = await addToCartUseCase(
        AddToCartParams(quantity: s.cartCount, product: s.product));

    result.fold(
      (l) => null,
      (r) => emit(ProductAddedToCart(s.product, s.cartCount)),
    );
  }
}
