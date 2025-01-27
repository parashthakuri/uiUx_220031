// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_by_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartByUserDTO _$GetCartByUserDTOFromJson(Map<String, dynamic> json) =>
    GetCartByUserDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      cart: CartAPIModel.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCartByUserDTOToJson(GetCartByUserDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'cart': instance.cart,
    };
