import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/auth/data/repository/auth_remote_repository_impl.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => ref.read(authRemoteRepositoryProvider));

abstract class AuthRepository {
  Future<Either<Failure, List<AuthEntity>>> getAllUser();
  Future<Either<Failure, bool>> register(AuthEntity user);
  Future<Either<Failure, bool>> login(String username, String password);
  Future<Either<Failure, AuthEntity>> getUserById(String userId);
  Future<Either<Failure, bool>> updateProfile(
      String email, String firstName, String lastNam, String userId);
}
