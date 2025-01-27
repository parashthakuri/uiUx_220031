import 'package:json_annotation/json_annotation.dart';
import 'package:sneakers_point/features/cart/domain/entity/cart_entity.dart';
import 'package:sneakers_point/features/product/data/model/product_api_model.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';

part 'cart_api_model.g.dart';

@JsonSerializable()
class CartAPIModel {
  @JsonKey(name: '_id')
  final String? id;
  final String user;
  final List<ProductInCartAPIModel> products;

  CartAPIModel({
    this.id,
    required this.user,
    required this.products,
  });

  factory CartAPIModel.fromJson(Map<String, dynamic> json) =>
      _$CartAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartAPIModelToJson(this);

  // Convert Entity to API Object
  // Convert Entity to API Object
  static CartAPIModel fromEntity(CartEntity entity) {
    return CartAPIModel(
      user: entity.user,
      products: entity.products
          .map((productEntity) => ProductInCartAPIModel(
                product: productEntity.product,
                quantity: productEntity.quantity,
              ))
          .toList(),
    );
  }

  // From API model to entity
  static CartEntity toEntity(CartAPIModel model) {
    return CartEntity(
      user: model.user,
      products: model.products
          .map((productInCartModel) => ProductInCartEntity(
              quantity: productInCartModel.quantity,
              product: productInCartModel.product))
          .toList(),
    );
  }
}

@JsonSerializable()
class ProductInCartAPIModel {
  final int quantity;
  final String product;

  ProductInCartAPIModel({
    required this.quantity,
    required this.product,
  });

  factory ProductInCartAPIModel.fromJson(Map<String, dynamic> json) =>
      _$ProductInCartAPIModelFromJson(json);
// From API model to entity
  ProductEntity toEntity(ProductInCartAPIModel model) {
    return ProductEntity(
      productId: model.product,
      productName: "", // Placeholder, should be replaced with actual value
      productPrice: 0, // Placeholder, should be replaced with actual value
      productDescription:
          "", // Placeholder, should be replaced with actual value
      productCategory: "", // Placeholder, should be replaced with actual value
      productImageUrl: "", // Placeholder, should be replaced with actual value
    );
  }

  Map<String, dynamic> toJson() => _$ProductInCartAPIModelToJson(this);
}
