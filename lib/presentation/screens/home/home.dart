import 'package:e_commerce/core/routes.dart';
import 'package:e_commerce/presentation/screens/home/categories_list.dart';
import 'package:e_commerce/presentation/screens/home/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:e_commerce/logic/controllers/home/home.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/states/home/home.dart';
import 'package:e_commerce/presentation/widgets/loading_error.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Store'),
          actions: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.addProduct),
                icon: Icon(Icons.add)),
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.cart),
                icon: Icon(FontAwesomeIcons.cartShopping)),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeError) {
              return LoadingError(
                retryCallback: () => context.read<HomeBloc>().load(),
                error: state.message,
              );
            }
            if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  // add option for all Items
                  children: [
                    CategoriesList(
                        categories: [Category("All"), ...state.categories]),
                    Expanded(
                      child: BlocSelector<HomeBloc, HomeState, Category>(
                        selector: (state) {
                          return (state as HomeLoaded).selectedCategory;
                        },
                        builder: (context, state) {
                          return ProductsList(category: state);
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
