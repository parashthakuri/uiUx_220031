import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';

class CategoryState {
  final bool isLoading;
  final List<CategoryEntity> categories;
  final List<CategoryEntity>
      filteredCategories; // Add filteredCategories property
  final bool showMessage;
  final bool showCategoryDeleteMessage;
  final String? error;

  CategoryState({
    required this.isLoading,
    required this.categories,
    required this.filteredCategories, // Initialize filteredCategories
    required this.showMessage,
    required this.showCategoryDeleteMessage,
    required this.error,
  });

  factory CategoryState.initialState() {
    return CategoryState(
      isLoading: false,
      categories: [],
      filteredCategories: [], // Initialize filteredCategories
      showMessage: false,
      showCategoryDeleteMessage: false,
      error: "",
    );
  }

  CategoryState copyWith({
    bool? isLoading,
    List<CategoryEntity>? categories,
    List<CategoryEntity>? filteredCategories,
    bool? showMessage,
    bool? showCategoryDeleteMessage,
    String? error,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      filteredCategories: filteredCategories ?? this.filteredCategories,
      showMessage: showMessage ?? this.showMessage,
      showCategoryDeleteMessage:
          showCategoryDeleteMessage ?? this.showCategoryDeleteMessage,
      error: error ?? this.error,
    );
  }
}
