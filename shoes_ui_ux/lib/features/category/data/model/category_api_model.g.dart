// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryAPIModel _$CategoryAPIModelFromJson(Map<String, dynamic> json) =>
    CategoryAPIModel(
      categoryId: json['_id'] as String?,
      categoryName: json['categoryName'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CategoryAPIModelToJson(CategoryAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.categoryId,
      'categoryName': instance.categoryName,
      'description': instance.description,
    };
