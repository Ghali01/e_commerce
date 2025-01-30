import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/logic/data/states/cart/cart.dart';
import 'package:e_commerce/logic/use_cases/cart/checkout_cart.dart';
import 'package:e_commerce/logic/use_cases/cart/delete_item.dart';
import 'package:e_commerce/logic/use_cases/cart/get_cart.dart';

class CartBloc extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase = GetCartUseCase();
  final DeleteCartItemUseCase deleteCartItemUseCase = DeleteCartItemUseCase();
  final CheckoutCartUseCase checkoutCartUseCase = CheckoutCartUseCase();
  CartBloc() : super(CartInitial());

  Future<void> load() async {
    emit(CartLoading());
    final result = await getCartUseCase(NoParams());
    result.fold(
        (l) => emit(CartLoadError(l.message)), (r) => emit(CartLoaded(r)));
  }

  //delete item from cart
  Future<void> deleteItem(int id) async {
    final result = await deleteCartItemUseCase(id);
    result.fold((l) => null, (r) {
      //delete the item from the state
      final items = (state as CartLoaded)
          .items
          .where((element) => element.id != id)
          .toList();
      emit(CartLoaded(items));
    });
  }

  //checkout
  Future<void> checkout() async {
    final s = state as CartLoaded;
    emit(CartCheckoutLoading(s.items));
    final result = await checkoutCartUseCase(NoParams());
    result.fold(
      (l) => emit(CartCheckoutError(l.message, s.items)),
      (r) => emit(CartCheckoutSuccess()),
    );
  }
}
