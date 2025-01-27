import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';

part 'product_api_model.g.dart';

final productApiModelProvider = Provider<ProductAPIModel>(
  (ref) => ProductAPIModel.empty(),
);

@JsonSerializable()
class ProductAPIModel {
  @JsonKey(name: '_id')
  final String? productId;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String productImageUrl;

  ProductAPIModel(
      {required this.productPrice,
      required this.productDescription,
      required this.productCategory,
      required this.productImageUrl,
      this.productId,
      required this.productName});

  // Static method to create an empty instance of ProductAPIModel
  ProductAPIModel.empty()
      : productName = '',
        productPrice = 0,
        productDescription = '',
        productCategory = '',
        productId = '',
        productImageUrl = '';

  factory ProductAPIModel.fromJson(Map<String, dynamic> json) =>
      _$ProductAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAPIModelToJson(this);

  // From entity to model
  factory ProductAPIModel.fromEntity(ProductEntity entity) {
    return ProductAPIModel(
      productId: entity.productId,
      productName: entity.productName,
      productPrice: entity.productPrice,
      productDescription: entity.productDescription,
      productCategory: entity.productCategory,
      productImageUrl: entity.productImageUrl!,
    );
  }

  // From model to entity
  ProductEntity toEntity(ProductAPIModel model) {
    return ProductEntity(
      productId: model.productId,
      productName: model.productName,
      productPrice: model.productPrice,
      productDescription: model.productDescription,
      productCategory: model.productCategory,
      productImageUrl: model.productImageUrl,
    );
  }
}
