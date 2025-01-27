import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/cart/data/repository/cart_repo_impl.dart';
import 'package:sneakers_point/features/cart/domain/entity/cart_entity.dart'; // Import the CartEntity

final cartRepositoryProvider = Provider<CartRepository>(
  (ref) {
    return ref.read(cartRemoteRepositoryProvider);
  },
);

abstract class CartRepository {
  Future<Either<Failure, bool>> addToCart(CartEntity cart);
  Future<Either<Failure, List<CartEntity>>>
      getAllCart(); // Method to retrieve all carts
  Future<Either<Failure, List<ProductInCartEntity>>> getCartByUserId(
      String userId); // Method to retrieve a cart by user ID
  Future<Either<Failure, bool>> removeFromCart(
      String cartId); // Method to remove a cart
}

// You would also need to create a CartEntity if not already created.
