import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/category/data/data_source/category_remote_data_source.dart';
import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';
import 'package:sneakers_point/features/category/domain/repository/category_repository.dart';

final categoryRemoteRepositoryProvider = Provider<CategoryRepository>(
  (ref) => CategoryRemoteRepository(
    categoryRemoteDataSource: ref.read(categoryRemoteDataSourceProvider),
  ),
);

class CategoryRemoteRepository implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRemoteRepository({required this.categoryRemoteDataSource});

  @override
  Future<Either<Failure, bool>> deleteCategory(String id) {
    // TODO: implement deleteCategory
    return categoryRemoteDataSource.deleteCategory(id);
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() {
    // TODO: implement getAllCategories
    return categoryRemoteDataSource.getAllCategories();
  }

  @override
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) {
    // TODO: implement addCategory
    return categoryRemoteDataSource.addCategory(category);
  }
}
