import 'package:e_commerce/logic/data/models/category.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductLoading extends AddProductState {}

class AddProductLoadError extends AddProductState {
  final String message;
  AddProductLoadError({
    required this.message,
  });
}

class AddProductLoaded extends AddProductState {
  final List<Category> categories;
  final Category? selectedCategory;
  AddProductLoaded({required this.categories, this.selectedCategory});

  //set selected  category
  AddProductLoaded selectCategory(Category category) =>
      AddProductLoaded(categories: categories, selectedCategory: category);

  AddProductError error(String message) => AddProductError(message,
      categories: categories, selectedCategory: selectedCategory);

  AddProductSubmitting submitting() => AddProductSubmitting(
      categories: categories, selectedCategory: selectedCategory);
  AddProductDone done() => AddProductDone(
      categories: categories, selectedCategory: selectedCategory);
}

class AddProductError extends AddProductLoaded {
  final String message;

  AddProductError(this.message,
      {required super.categories, super.selectedCategory});
}

class AddProductSubmitting extends AddProductLoaded {
  AddProductSubmitting({required super.categories, super.selectedCategory});
}

class AddProductDone extends AddProductLoaded {
  AddProductDone({required super.categories, super.selectedCategory});
}
