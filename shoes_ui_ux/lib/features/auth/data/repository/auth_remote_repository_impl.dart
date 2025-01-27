import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:sneakers_point/features/auth/data/model/auth_api_model.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';
import 'package:sneakers_point/features/auth/domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<AuthREemoteRepositoryImpl>(
    (ref) => AuthREemoteRepositoryImpl(
        authRemoteDataSource: ref.read(authRemoteDataSourceProvider)));

class AuthREemoteRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthREemoteRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, bool>> register(AuthEntity user) {
    return authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, bool>> login(String username, String password) {
    return authRemoteDataSource.login(username, password);
  }

  @override
  Future<Either<Failure, AuthEntity>> getUserById(String userId) {
    return authRemoteDataSource.getUserById(userId);
  }

  @override
  Future<Either<Failure, List<AuthEntity>>> getAllUser() {
    return authRemoteDataSource.getAllUsers();
  }

  @override
  Future<Either<Failure, bool>> updateProfile(
      String email, String firstName, String lastName, String userId) {
    // TODO: implement updateProfile
    return authRemoteDataSource.updateProfile(
        email, firstName, lastName, userId);
  }
}
