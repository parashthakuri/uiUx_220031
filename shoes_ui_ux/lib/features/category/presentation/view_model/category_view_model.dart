import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';
import 'package:sneakers_point/features/category/domain/use_case/category_usecase.dart';
import 'package:sneakers_point/features/category/presentation/state/category_state.dart';

final categoryViewModelProvider =
    StateNotifierProvider<CategoryViewModel, CategoryState>(
  (ref) => CategoryViewModel(
    ref.read(categoryUseCaseProvider),
  ),
);

class CategoryViewModel extends StateNotifier<CategoryState> {
  final Logger logger = Logger();
  final CategoryUseCase categoryUsecase;

  CategoryViewModel(this.categoryUsecase)
      : super(CategoryState.initialState()) {
    getAllCategories();
  }

  //todo: get all categories
  Future<void> getAllCategories() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final result = await categoryUsecase.getAllCategories();
    result.fold(
      (failure) => state = state.copyWith(isLoading: false),
      (data) {
        state = state.copyWith(
          isLoading: false,
          categories: [...currentState.categories, ...data],
        );
      },
    );
  }

  // //todo: search category
  // void searchCategory(String query) async {
  //   state = state.copyWith(isLoading: true);
  //   final result = await categoryUsecase.searchCategories(query);
  //   result.fold(
  //     (failure) {
  //       state = state.copyWith(isLoading: false, error: failure.error);
  //     },
  //     (categories) {
  //       logger.d('Category details fetched successfully: $categories');
  //       state = state.copyWith(
  //         isLoading: false,
  //         filteredCategories: categories,
  //         error: null,
  //       );
  //     },
  //   );
  // }

  //todo: add category
  Future<void> addCategory(CategoryEntity category) async {
    // You might not need an image for adding a category
    state = state.copyWith(isLoading: true);
    final result = await categoryUsecase.addCategory(category);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false),
      (isAdded) {
        state = state.copyWith(isLoading: false, showMessage: true);
        getAllCategories();
      },
    );
  }

  //todo: delete category
  Future<void> deleteCategory(String id) async {
    state = state.copyWith(isLoading: true);
    final result = await categoryUsecase.deleteCategory(id);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false),
      (isDeleted) {
        state =
            state.copyWith(isLoading: false, showCategoryDeleteMessage: true);
        getAllCategories();
      },
    );
  }

  void resetMessage(bool value) {
    state =
        state.copyWith(showMessage: value, showCategoryDeleteMessage: value);
  }
}
