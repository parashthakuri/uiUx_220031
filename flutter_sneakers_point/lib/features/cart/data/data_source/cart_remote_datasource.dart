import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sneakers_point/config/constants/api_endpoints.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/core/network/http_service.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/cart/data/dto/get_cart_by_user_dto.dart';
import 'package:sneakers_point/features/cart/data/model/cart_api_model.dart';
import 'package:sneakers_point/features/cart/domain/entity/cart_entity.dart';

final cartRemoteDataSourceProvider = Provider.autoDispose<CartRemoteDataSource>(
  (ref) => CartRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class CartRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;
  final logger = Logger();
  CartRemoteDataSource({required this.userSharedPrefs, required this.dio});

  Future<Either<Failure, List<ProductInCartEntity>>> getCartByUserId(
      String userId) async {
    try {
      // get token
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));

      var response = await dio.get(ApiEndpoints.getCartById + userId,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));
      if (response.statusCode == 200) {
        GetCartByUserDTO getCartByIdDTO =
            GetCartByUserDTO.fromJson(response.data);

        // Extracting the cart directly from DTO
        // CartAPIModel cartAPIModel = getCartByIdDTO.cart;

        List<ProductInCartEntity> cartProducts = getCartByIdDTO.cart.products
            .map((item) => ProductInCartEntity(
                  product: item.product,
                  quantity: item.quantity,
                ))
            .toList(); // Convert CartAPIModel to CartEntity

        // logger.w('Cart Entity: $cartEntity');
        // Return the CartEntity
        return Right(cartProducts);
      } else {
        return Left(Failure(
          error: response.statusMessage.toString(),
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      logger.w('Dio Error: $e'); // Debug line
      return Left(Failure(error: e.response?.data['message']));
    } catch (e) {
      logger.w('Error: $e'); // Debug line
      return Left(Failure(error: e.toString()));
    }
  }

// Future<Either<Failure, CartEntity>> getCartByUserId(String userId) async {
//   try {
//     var response = await dio.get(ApiEndpoints.getCartById + userId);
//     if (response.statusCode == 200) { // Assuming 200 is the correct status code for a successful response
//       GetCartByUserDTO getCartByIdDTO = GetCartByUserDTO.fromJson(response.data);

//       // Convert DTO to CartAPIModel
//       CartAPIModel cartAPIModel = CartAPIModel.fromJson(getCartByIdDTO.cart as Map<String, dynamic>);

//       // Convert CartAPIModel to CartEntity
//       CartEntity cartEntity = CartAPIModel.toEntity(cartAPIModel);

//       // Debug line
//       logger.w('Cart Entity: $cartEntity');

//       // Return the CartEntity
//       return Right(cartEntity);
//     } else {
//       return Left(Failure(
//         error: response.statusMessage.toString(),
//         statusCode: response.statusCode.toString(),
//       ));
//     }
//   } on DioException catch (e) {
//     logger.w('Dio Error: $e'); // Debug line
//     return Left(Failure(error: e.response?.data['message']));
//   } catch (e) {
//     logger.w('Error: $e'); // Debug line
//     return Left(Failure(error: e.toString()));
//   }
// }

  Future<Either<Failure, bool>> addToCart(CartEntity cart) async {
    try {
      var response = await dio.post(
        ApiEndpoints.addToCart,
        data: CartAPIModel.fromEntity(cart).toJson(),
      );
      // Assuming the API returns a success boolean
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

  Future<Either<Failure, bool>> removeCart(String userId) async {
    try {
      final response =
          await dio.delete(ApiEndpoints.deleteProductFromCart + userId);
      // Assuming the API returns a success boolean
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
}
