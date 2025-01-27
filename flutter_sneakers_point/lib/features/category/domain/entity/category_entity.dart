import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? categoryId;
  final String categoryName;
  final String description;

  const CategoryEntity({
    this.categoryId,
    required this.categoryName,
    required this.description,
  });

  @override
  List<Object?> get props => [categoryId, categoryName, description];

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'CategoryEntity(categoryId: $categoryId, categoryName: $categoryName, description: $description)';
  }
}
