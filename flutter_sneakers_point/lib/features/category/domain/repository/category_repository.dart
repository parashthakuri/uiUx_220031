import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';
import 'package:sneakers_point/features/category/data/repository/category_remote_repository.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) {
    return ref.read(categoryRemoteRepositoryProvider);
  },
);

abstract class CategoryRepository {
  Future<Either<Failure, bool>> addCategory(CategoryEntity category);
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
  Future<Either<Failure, bool>> deleteCategory(String id);
}
