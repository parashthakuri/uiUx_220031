// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserByIdDTO _$GetUserByIdDTOFromJson(Map<String, dynamic> json) =>
    GetUserByIdDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: AuthAPIModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetUserByIdDTOToJson(GetUserByIdDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'user': instance.user,
    };
