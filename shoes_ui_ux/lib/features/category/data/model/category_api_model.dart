import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/category/domain/entity/category_entity.dart';

part 'category_api_model.g.dart';

final categoryApiModelProvider =
    Provider<CategoryAPIModel>((ref) => const CategoryAPIModel.empty());

@JsonSerializable()
class CategoryAPIModel extends Equatable {
  @JsonKey(name: '_id')
  final String? categoryId;
  final String categoryName;
  final String description;

  const CategoryAPIModel({
    this.categoryId,
    required this.categoryName,
    required this.description,
  });

  const CategoryAPIModel.empty()
      : categoryId = '',
        categoryName = '',
        description = "";

  factory CategoryAPIModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryAPIModelToJson(this);

  @override
  List<Object?> get props => [categoryId, categoryName, description];

  // From entity to model
  factory CategoryAPIModel.fromEntity(CategoryEntity entity) {
    return CategoryAPIModel(
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
      description: entity.description,
    );
  }

// From model to entity
  CategoryEntity toEntity(CategoryAPIModel model) {
    return CategoryEntity(
      categoryId: model.categoryId,
      categoryName: model.categoryName,
      description: model.description,
    );
  }
}
