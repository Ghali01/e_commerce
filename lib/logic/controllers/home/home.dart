import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/base_use_case.dart';
import 'package:e_commerce/logic/data/models/category.dart';
import 'package:e_commerce/logic/data/states/home/home.dart';
import 'package:e_commerce/logic/use_cases/home/get_categories.dart';

class HomeBloc extends Cubit<HomeState> {
  final GetCategoriesUseCase useCase = GetCategoriesUseCase();
  HomeBloc() : super(HomeInitial());

  Future<void> load() async {
    emit(HomeLoading());
    final result = await useCase(NoParams());
    result.fold((l) => emit(HomeError(message: l.message)),
        (r) => emit(HomeLoaded(categories: r)));
  }

  void selectCategory(Category category) =>
      emit((state as HomeLoaded).selectCategory(category));
}
