import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';
import 'package:sneakers_point/features/category/domain/repository/category_repository.dart';

final categoryUseCaseProvider = Provider<CategoryUseCase>(
  (ref) =>
      CategoryUseCase(categoryRepository: ref.read(categoryRepositoryProvider)),
);

class CategoryUseCase {
  final CategoryRepository categoryRepository;

  CategoryUseCase({required this.categoryRepository});

  Future<Either<Failure, bool>> addCategory(CategoryEntity category) async {
    // You might not need an image for adding a category
    return await categoryRepository.addCategory(category);
  }

  Future<Either<Failure, bool>> deleteCategory(String id) async {
    return await categoryRepository.deleteCategory(id);
  }

  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    return await categoryRepository.getAllCategories();
  }
}
