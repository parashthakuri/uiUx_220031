import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:sneakers_point/features/cart/data/data_source/cart_remote_datasource.dart';
import 'package:sneakers_point/features/cart/domain/entity/cart_entity.dart';
import 'package:sneakers_point/features/cart/domain/repository/cart_repository.dart';

final cartRemoteRepositoryProvider = Provider<CartRepository>(
  (ref) => CartRepoImplementation(
    cartRemoteDataSource: ref.read(cartRemoteDataSourceProvider),
  ),
);

class CartRepoImplementation implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepoImplementation({required this.cartRemoteDataSource});
  @override
  Future<Either<Failure, bool>> addToCart(CartEntity cart) {
    // TODO: implement addToCart
    return cartRemoteDataSource.addToCart(cart);
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getAllCart() {
    // TODO: implement getAllCart
    throw UnimplementedError();
  }

// Implement the method to get cart by user ID
  @override
  Future<Either<Failure, List<ProductInCartEntity>>> getCartByUserId(
      String userId) {
    return cartRemoteDataSource.getCartByUserId(userId);
  }

  @override
  Future<Either<Failure, bool>> removeFromCart(String cartId) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }
}
