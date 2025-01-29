import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce/logic/controllers/home/products_list.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/states/home/products_list.dart';
import 'package:e_commerce/presentation/widgets/loading_error.dart';

class ProductsList extends StatelessWidget {
  final Category category;
  const ProductsList({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: ValueKey(category),
      create: (context) => ProductsListBloc(category)..load(),
      child: Scaffold(
        body: BlocBuilder<ProductsListBloc, ProductsListState>(
          builder: (context, state) {
            if (state is ProductsListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductsListError) {
              return LoadingError(
                retryCallback: () => context.read<ProductsListBloc>().load(),
                error: state.message,
              );
            }
            if (state is ProductsListLoaded) {
              return ListView.builder(
                itemCount: state.productsList.length,
                itemBuilder: (context, index) {
                  final product = state.productsList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: SizedBox(
                          width: 60,
                          child: Image.network(
                            product.image,
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator()),
                          ),
                        ),
                        title: Text(product.title),
                        subtitle: Text(
                          product.description,
                          maxLines: 3,
                        ),
                        trailing: Text("${product.price}\$"),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
