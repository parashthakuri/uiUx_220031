import 'package:equatable/equatable.dart';
import 'package:sneakers_point/features/auth/data/model/auth_api_model.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const AuthEntity({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, firstName, lastName, email, password];

  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
      userId: json['userId'],
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": userId,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
    };
  }

  @override
  String toString() {
    return 'AuthEntity(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, password: $password)';
  }

  factory AuthEntity.fromAPIModel(AuthAPIModel apiModel) {
    return AuthEntity(
      userId: apiModel.userId,
      firstName: apiModel.firstName,
      lastName: apiModel.lastName,
      email: apiModel.email,
      password: apiModel.password,
    );
  }
}
