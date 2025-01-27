import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';
import 'package:sneakers_point/features/auth/domain/repository/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;
  final UserSharedPrefs _userSharedPrefs;

  AuthUseCase(this._authRepository, this._userSharedPrefs);

  Future<Either<Failure, List<AuthEntity>>> getAllUser() async {
    return _authRepository.getAllUser();
  }

  Future<Either<Failure, AuthEntity>> getUserById(String userId) async {
    return _authRepository.getUserById(userId);
  }

  Future<Either<Failure, bool>> login(String username, String password) async {
    return await _authRepository.login(username, password);
  }

  Future<Either<Failure, bool>> register(AuthEntity user) async {
    return await _authRepository.register(user);
  }

  Future<Either<Failure, bool>> updateProfile(
      String email, String firstName, String lastName, String userId) async {
    return _authRepository.updateProfile(email, firstName, lastName, userId);
  }
}

final authUseCaseProvider = Provider<AuthUseCase>((ref) => AuthUseCase(
      ref.read(authRepositoryProvider),
      ref.read(userSharedPrefsProvider),
    ));
