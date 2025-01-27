// import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';
import 'package:sneakers_point/features/product/data/model/product_api_model.dart';

class ProductEntity extends Equatable {
  final String? productId;
  final String productName;
  final int productPrice;
  final String productDescription;
  final String productCategory;
  final String? productImageUrl;

  const ProductEntity(
      {this.productId,
      required this.productName,
      required this.productPrice,
      required this.productDescription,
      required this.productCategory,
      this.productImageUrl});

  // Static method to create an empty instance of ProductEntity
  static ProductEntity empty() {
    return const ProductEntity(
      productName: '',
      productPrice: 0,
      productDescription: '',
      productCategory: '',
      productImageUrl: null,
    );
  }

  factory ProductEntity.fromAPIModel(ProductAPIModel apiModel) {
    return ProductEntity(
      productId: apiModel.productId,
      productName: apiModel.productName,
      productPrice: apiModel.productPrice,
      productDescription: apiModel.productDescription,
      productCategory: apiModel.productCategory,
      productImageUrl: apiModel.productImageUrl,
    );
  }
  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        productId:
            json["_id"], // Accessing the $oid field within the _id object
        productName: json["productName"],
        productPrice: json["productPrice"],
        productDescription: json["productDescription"],
        productCategory: json["productCategory"],
        productImageUrl: json["productImageUrl"],
      );
  @override
  String toString() {
    return 'ProductEntity(productId: $productId, productName: $productName, productPrice: $productPrice, productDescription: $productDescription, productCategory: $productCategory, productImageurl: $productImageUrl)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
