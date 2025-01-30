import 'package:e_commerce/logic/controllers/product/product.dart';
import 'package:e_commerce/logic/data/states/product/product.dart';
import 'package:e_commerce/presentation/widgets/loading_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//arguments to be passed to the navigator
class ProductArgs {
  final int id;
  ProductArgs({
    required this.id,
  });
}

class ProductScreen extends StatelessWidget {
  final ProductArgs args;
  const ProductScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(args.id)..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Details'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductError) {
              return LoadingError(
                retryCallback: () => context.read<ProductBloc>().load(),
                error: state.message,
              );
            }
            if (state is ProductLoaded) {
              return ListView(
                padding: EdgeInsets.all(8),
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * .75,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 130,
                              child: Image.network(
                                state.product.image,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.product.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ...List.generate(
                                          5,
                                          (index) => Icon(
                                            index < 4
                                                ? Icons.star
                                                : Icons.star_outline,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        Text(
                                          '120 reviews',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(state.product.description)
                      ],
                    ),
                  ),
                  //counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () =>
                              context.read<ProductBloc>().setCounter(-1),
                          icon: Icon(Icons.remove)),
                      BlocSelector<ProductBloc, ProductState, int>(
                        selector: (state) {
                          return (state as ProductLoaded).cartCount;
                        },
                        builder: (context, state) {
                          return Text(
                            state.toString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          );
                        },
                      ),
                      IconButton(
                          onPressed: () =>
                              context.read<ProductBloc>().setCounter(1),
                          icon: Icon(Icons.add)),
                    ],
                  ),

                  ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text('Add to cart'),
                      icon: const Icon(Icons.add_shopping_cart))
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
