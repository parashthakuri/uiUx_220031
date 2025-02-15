import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthAPIModel>((ref) {
  return AuthAPIModel(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
  );
});

@JsonSerializable()
class AuthAPIModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  AuthAPIModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory AuthAPIModel.fromJson(Map<String, dynamic> json) =>
      _$AuthAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthAPIModelToJson(this);

  factory AuthAPIModel.fromEntity(AuthEntity entity) {
    return AuthAPIModel(
      userId: entity.userId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
  }

  // Convert AuthApiModel list to AuthEntity list
  List<AuthEntity> listFromJson(List<AuthAPIModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'AuthApiModel(id: $userId, fname: $firstName, lname: $lastName, email: $email, password: $password)';
  }
}


// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';

// part 'auth_api_model.g.dart';
// final authApiModelProvider = Provider<AuthAPIModel>((ref){
// return AuthAPIModel(firstName: "", lastName: '', email: '', password: '');
// });

// @JsonSerializable()
// class AuthAPIModel {
//   @JsonKey(name: '_id')
//   final String? userId;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String password;

//   AuthAPIModel(
//       {this.userId,
//       required this.firstName,
//       required this.lastName,
//       required this.email,
//       required this.password});

//   //* to json and from json
//   factory AuthAPIModel.fromJson(Map<String, dynamic> json) {
//     return AuthAPIModel(
//         userId: json['userId'],
//         firstName: json['firstName'] as String,
//         lastName: json['lastName'] as String,
//         email: json['email'] as String,
//         password: json['password'] as String);
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": userId,
//       "first_name": firstName,
//       "last_name": lastName,
//       "email": email,
//       "password": password
//     };
//   }

//   //*From entity to  model
//   factory AuthAPIModel.fromEntity(AuthEntity entity) {
//     return AuthAPIModel(
//         firstName: entity.firstName,
//         lastName: entity.lastName,
//         email: entity.email,
//         password: entity.password);
//   }

//   //* From model to entity
//   static AuthEntity toEntity(AuthAPIModel model) {
//     return AuthEntity(
//         userId: model.userId,
//         firstName: model.firstName,
//         lastName: model.lastName,
//         email: model.email,
//         password: model.password);
//   }


// }
