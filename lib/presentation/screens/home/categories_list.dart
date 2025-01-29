import 'package:e_commerce/logic/controllers/home/home.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/states/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  final List<Category> categories;
  const CategoriesList({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocSelector<HomeBloc, HomeState, Category>(
        selector: (state) {
          return (state as HomeLoaded).selectedCategory;
        },
        builder: (context, state) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.only(start: 8),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(0),
                      foregroundColor: WidgetStatePropertyAll(state == category
                          ? Theme.of(context).colorScheme.onPrimary
                          : const Color(0xff28313f)),
                      backgroundColor: WidgetStatePropertyAll(state == category
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.inversePrimary),
                    ),
                    onPressed: () {
                      context.read<HomeBloc>().selectCategory(category);
                    },
                    child: Text(category.name)),
              );
            },
          );
        },
      ),
    );
  }
}
