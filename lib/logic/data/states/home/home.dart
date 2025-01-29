import 'package:e_commerce/logic/data/models/category.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final Category selectedCategory;
  HomeLoaded({
    required this.categories,
    this.selectedCategory = const Category("All"),
  });

  HomeLoaded selectCategory(Category category) =>
      HomeLoaded(categories: categories, selectedCategory: category);
}
