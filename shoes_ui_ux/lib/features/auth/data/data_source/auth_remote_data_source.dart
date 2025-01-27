import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sneakers_point/config/constants/api_endpoints.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/core/network/http_service.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/auth/data/dto/get_all_user_dto.dart';
import 'package:sneakers_point/features/auth/data/model/auth_api_model.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) =>
    AuthRemoteDataSource(ref.read(httpServiceProvider),
        ref.read(authApiModelProvider), ref.read(userSharedPrefsProvider)));

class AuthRemoteDataSource {
  final Logger logger = Logger();
  final Dio dio;
  final AuthAPIModel authAPIModel;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource(this.dio, this.authAPIModel, this.userSharedPrefs);

  Future<Either<Failure, bool>> registerUser(AuthEntity student) async {
    try {
      AuthAPIModel apiModel = AuthAPIModel.fromEntity(student);
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstName": apiModel.firstName,
          "lastName": apiModel.lastName,
          "email": apiModel.email,
          "password": apiModel.password,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, AuthEntity>> getUserById(String userId) async {
    try {
      var response = await dio.get(ApiEndpoints.getUserById + userId);
      if (response.statusCode == 200) {
        // Deserialize the response JSON to an AuthAPIModel
        AuthAPIModel user = AuthAPIModel.fromJson(response.data['user']);

        // Convert the AuthAPIModel to an AuthEntity
        AuthEntity authEntity = AuthEntity.fromAPIModel(user);

        return Right(authEntity);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

//todo: update profile
  Future<Either<Failure, bool>> updateProfile(
      String email, String firstName, String lastName, String userId) async {
    try {
      // Create a map with updated profile fields
      final updatedData = {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
      };

      // Make API call to update profile
      final response = await dio.put(
        ApiEndpoints.updateProfile + userId,
        data: updatedData,
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Adding a login function to AuthRemoteDataSource.dart
  Future<Either<Failure, bool>> login(String username, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // Handle successful login response, if needed
        // You might want to store tokens or user information
        String token = response.data["token"];
        logger.w('token value: $token');
        bool isAdmin = response.data['userData']["isAdmin"];

        String userId = response.data["userData"]["_id"];

        // // debugPrint(isAdmin);

        logger.w('isAdmin value: $isAdmin');
        logger.w('User id: $userId');

        await userSharedPrefs.setUserToken(token);
        await userSharedPrefs.setIsAdmin(isAdmin);
        await userSharedPrefs.setUserId(userId);

        // logger.w('isAdmin value: $isAdmin');
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<AuthEntity>>> getAllUsers() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllUser);
      if (response.statusCode == 200) {
        GetAllUserDTO getAllUserDto = GetAllUserDTO.fromJson(response.data);
        return Right(authAPIModel.listFromJson(getAllUserDto.users));
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
