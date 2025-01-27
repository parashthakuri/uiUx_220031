import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/cart/domain/entity/cart_entity.dart';
import 'package:sneakers_point/features/cart/domain/repository/cart_repository.dart';

final cartUseCaseProvider = Provider<CartUseCase>(
  (ref) => CartUseCase(cartRepository: ref.read(cartRepositoryProvider)),
);

class CartUseCase {
  final CartRepository cartRepository;

  CartUseCase({required this.cartRepository});

  Future<Either<Failure, bool>> addToCart(CartEntity cart) async {
    return await cartRepository.addToCart(cart);
  }

  Future<Either<Failure, bool>> removeFromCart(String cartId) async {
    return await cartRepository.removeFromCart(cartId);
  }

  Future<Either<Failure, List<CartEntity>>> getAllCart() async {
    return await cartRepository.getAllCart();
  }

  Future<Either<Failure, List<ProductInCartEntity>>> getCartByUserId(
      String userId) async {
    return await cartRepository.getCartByUserId(userId);
  }
}
