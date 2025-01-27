import 'package:equatable/equatable.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';

class CartEntity extends Equatable {
  final String? id;
  final String user;
  final List<ProductInCartEntity> products;

  CartEntity({
    this.id,
    required this.user,
    required this.products,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProductInCartEntity extends Equatable {
  final List<ProductEntity>? products;
  final int quantity;
  final String product;

  ProductInCartEntity({
    this.products,
    required this.quantity,
    required this.product,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
