// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_by_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductByIdDTO _$GetProductByIdDTOFromJson(Map<String, dynamic> json) =>
    GetProductByIdDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      product:
          ProductAPIModel.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProductByIdDTOToJson(GetProductByIdDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'product': instance.product,
    };
