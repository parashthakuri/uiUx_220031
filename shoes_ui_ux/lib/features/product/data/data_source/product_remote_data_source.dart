import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/config/constants/api_endpoints.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/core/network/http_service.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/product/data/dto/get_all_product_dto.dart';
import 'package:sneakers_point/features/product/data/dto/get_product_by_id_dto.dart';
import 'package:sneakers_point/features/product/data/model/product_api_model.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';

final productRemoteDataSourceProvider =
    Provider.autoDispose<ProductRemoteDataSource>(
  (ref) => ProductRemoteDataSource(
      dio: ref.read(httpServiceProvider),
      userSharedPrefs: ref.read(userSharedPrefsProvider),
      productAPIModel: ref.read(productApiModelProvider)),
);

class ProductRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final ProductAPIModel productAPIModel;

  ProductRemoteDataSource(
      {required this.dio,
      required this.userSharedPrefs,
      required this.productAPIModel});

  //todo: add product
  Future<Either<Failure, bool>> addProduct(
      ProductEntity product, File? img) async {
    try {
      FormData formData = FormData.fromMap({
        'productName': product.productName,
        'productDescription': product.productDescription,
        'productPrice': product.productPrice,
        'productCategory': product.productCategory,
        'productImage': img != null
            ? await MultipartFile.fromFile(img.path,
                filename: img.path.split('/').last)
            : null,
      });
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));
      var response = await dio.post(ApiEndpoints.createProduct,
          data: formData,
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

  //todo: get all products
  Future<Either<Failure, List<ProductEntity>>> getAllProduct() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllProducts);

      if (response.statusCode == 200) {
        //* Convert ProductAPIModel to ProductEntity
        GetAllProductDTO productAddDTO =
            GetAllProductDTO.fromJson(response.data);
        List<ProductEntity> productList = productAddDTO.products
            .map((product) => productAPIModel.toEntity(product))
            .toList();

        return Right(productList);
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

  //todo: get product by id
  Future<Either<Failure, ProductEntity>> getProductById(
      String productId) async {
    try {
      // get token
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));
      var response = await dio.get(ApiEndpoints.getSingleProduct + productId,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        GetProductByIdDTO getProductByIdDTO =
            GetProductByIdDTO.fromJson(response.data);
        ProductEntity productEntity =
            productAPIModel.toEntity(getProductByIdDTO.product);
        return Right(productEntity);
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

  //todo: search products
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      String query) async {
    try {
      var response =
          await dio.get(ApiEndpoints.searchProducts, queryParameters: {
        "query": query,
      });

      if (response.statusCode == 200) {
        //* Convert ProductAPIModel to ProductEntity
        GetAllProductDTO productAddDTO =
            GetAllProductDTO.fromJson(response.data);
        List<ProductEntity> productList = productAddDTO.products
            .map((product) => productAPIModel.toEntity(product))
            .toList();

        return Right(productList);
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

// todo: delete product
  Future<Either<Failure, bool>> deleteProduct(String productId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteProduct + productId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
              error: response.data['message'],
              statusCode: response.statusCode.toString()),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
