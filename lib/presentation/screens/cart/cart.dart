import 'package:e_commerce/core/routes.dart';
import 'package:e_commerce/logic/controllers/cart/cart.dart';
import 'package:e_commerce/logic/data/states/cart/cart.dart';
import 'package:e_commerce/presentation/widgets/error_dialog.dart';
import 'package:e_commerce/presentation/widgets/loading_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartCheckoutError) {
              showDialog(
                  context: context,
                  builder: (_) => ErrorDialog(error: state.message));
            }
            if (state is CartCheckoutSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.home,
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartLoadError) {
              return LoadingError(
                  retryCallback: () => context.read<CartBloc>().load());
            }
            if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text('Cart is empty'),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (ctx, index) {
                          final item = state.items[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                leading: SizedBox(
                                  width: 60,
                                  child: Image.network(
                                    item.image,
                                    loadingBuilder: (context, child,
                                            loadingProgress) =>
                                        loadingProgress == null
                                            ? child
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                  ),
                                ),
                                title: Text(item.name),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${item.price}\$"),
                                    Text('quantity: ${item.quantity}'),
                                  ],
                                ),
                                trailing: IconButton(
                                    onPressed: () => context
                                        .read<CartBloc>()
                                        .deleteItem(item.id),
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.redAccent,
                                    )),
                              ),
                            ),
                          );
                        }),
                  ),
                  if (state is CartCheckoutLoading)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () => context.read<CartBloc>().checkout(),
                          child: const Text('checkout')),
                    )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
