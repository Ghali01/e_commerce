import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/models/product.dart';
import 'package:e_commerce/logic/data/states/add_product/add_product.dart';
import 'package:e_commerce/logic/use_cases/add_product/add_product.dart';
import 'package:e_commerce/logic/use_cases/home/get_categories.dart';
import 'package:flutter/material.dart';

class AddProductBloc extends Cubit<AddProductState> {
  //controllers
  TextEditingController nameController = TextEditingController(),
      priceController = TextEditingController(),
      descriptionController = TextEditingController(),
      imageController = TextEditingController();

  //use cases
  final addProductUseCase = AddProductUseCase();
  final getCategoriesUseCase = GetCategoriesUseCase();

  AddProductBloc() : super(AddProductInitial());

  //load
  Future<void> load() async {
    emit(AddProductLoading());
    final result = await getCategoriesUseCase(NoParams());
    result.fold(
      (l) => emit(AddProductLoadError(message: l.message)),
      (r) => emit(AddProductLoaded(categories: r)),
    );
  }

  //submit
  Future<void> submit() async {
    final s = state as AddProductLoaded;
    if (state is! AddProductSubmitting) {
      emit(s.submitting());

      final result = await addProductUseCase(Product(
          id: 0,
          title: nameController.text,
          image: imageController.text,
          price: priceController.text,
          description: descriptionController.text,
          category: s.selectedCategory!.name));
      result.fold(
        (l) => emit(s.error(l.message)),
        (r) => emit(s.done()),
      );
    }
  }

  //category selected
  void selectCategory(Category category) =>
      emit((state as AddProductLoaded).selectCategory(category));
}
