import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  // Set user token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Get user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Set user ID
  Future<Either<Failure, bool>> setUserId(String userId) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('userId', userId);
      return right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Get user ID
  Future<Either<Failure, String?>> getUserId() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final userId = _sharedPreferences.getString('userId');
      return right(userId);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Set isAdmin status
  Future<Either<Failure, bool>> setIsAdmin(bool isAdmin) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setBool('isAdmin', isAdmin);
      return right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  // Get isAdmin status
  Future<Either<Failure, bool>> getIsAdmin() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final isAdmin = _sharedPreferences.getBool('isAdmin') ??
          false; // Default value if not set
      return right(isAdmin);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
