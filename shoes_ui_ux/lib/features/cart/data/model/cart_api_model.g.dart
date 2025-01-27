// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartAPIModel _$CartAPIModelFromJson(Map<String, dynamic> json) => CartAPIModel(
      id: json['_id'] as String?,
      user: json['user'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductInCartAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartAPIModelToJson(CartAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'products': instance.products,
    };

ProductInCartAPIModel _$ProductInCartAPIModelFromJson(
        Map<String, dynamic> json) =>
    ProductInCartAPIModel(
      quantity: json['quantity'] as int,
      product: json['product'] as String,
    );

Map<String, dynamic> _$ProductInCartAPIModelToJson(
        ProductInCartAPIModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product,
    };
