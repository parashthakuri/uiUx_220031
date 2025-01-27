import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/config/constants/api_endpoints.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/core/network/http_service.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/category/data/dto/get_all_category_dto.dart';
import 'package:sneakers_point/features/category/data/model/category_api_model.dart';
import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';

final categoryRemoteDataSourceProvider =
    Provider.autoDispose<CategoryRemoteDataSource>(
  (ref) => CategoryRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
    categoryAPIModel: ref.read(categoryApiModelProvider),
  ),
);

class CategoryRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final CategoryAPIModel categoryAPIModel;

  CategoryRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.categoryAPIModel});

  //todo: add category
  Future<Either<Failure, bool>> addCategory(CategoryEntity category) async {
    try {
      // get token
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));
      var response = await dio.post(ApiEndpoints.createCategory,
          data: category.toJson(),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Failure(
          error: response.statusMessage.toString(),
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  //todo: get all categories
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllCategories);
      if (response.statusCode == 200) {
        GetAllCategoryDTO getAllCategoryDTO =
            GetAllCategoryDTO.fromJson(response.data);
        List<CategoryEntity> categoryList = getAllCategoryDTO.categories
            .map((category) => categoryAPIModel.toEntity(category))
            .toList();
        return Right(categoryList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  //todo: delete category
  Future<Either<Failure, bool>> deleteCategory(String categoryId) async {
    try {
      // get token
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));
      var response = await dio.delete(ApiEndpoints.deleteCategory + categoryId,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
