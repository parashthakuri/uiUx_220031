import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/cart/domain/entity/cart_entity.dart';
import 'package:sneakers_point/features/cart/domain/use_case/cart_usecase.dart';
import 'package:sneakers_point/features/cart/presentation/state/cart_state.dart';

final cartViewModelProvider = StateNotifierProvider<CartViewModel, CartState>(
  (ref) => CartViewModel(
    ref.read(cartUseCaseProvider),
    ref.read(userSharedPrefsProvider),
  ),
);

class CartViewModel extends StateNotifier<CartState> {
  final Logger logger = Logger();
  final CartUseCase cartUseCase;
  final UserSharedPrefs userSharedPrefs;

  CartViewModel(
    this.cartUseCase,
    this.userSharedPrefs,
  ) : super(CartState.initialState()) {
    fetchCartByUser();
  }

// //todo: Fetch cart by user
  fetchCartByUser() async {
    // Start loading state
    state = state.copyWith(isLoading: true);

    // Extract userId from Either<Failure, String>
    final userId = await _getUserIdFromSharedPrefs();

    // Fetch cart using the obtained userId
    final result = await cartUseCase.getCartByUserId(userId);
    result.fold(
        (failure) =>
            state = state.copyWith(isLoading: false, error: failure.error),
        (cart) => {
              state = state.copyWith(isLoading: false, carts: cart, error: null)
              // showSnackBar(message: 'fetched cart', context: context)
            });
  }

  Future<String> _getUserIdFromSharedPrefs() async {
    final userIdEither = await userSharedPrefs.getUserId();
    return userIdEither.fold(
      (failure) {
        // Log error and return default user ID
        logger.e('Failed to get user ID from shared preferences: $failure');
        return 'default_user_id';
      },
      (userId) => userId!,
    );
  }

  // todo: Add to cart
  Future<void> addToCart(CartEntity cart) async {
    state = state.copyWith(isLoading: true);
    final result = await cartUseCase.addToCart(cart);
    result.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        state =
            state.copyWith(isLoading: false, error: null, showMessage: true);
        // showSnackBar(message: "Add to  cart success", context: context);
      },
    );
    // Call fetchCartByUser regardless of the result
    fetchCartByUser();
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }

  //todo: Delete from cart
  // Future<void> deleteFromCart(String cartId) async {
  //   state = state.copyWith(isLoading: true);
  //   final result = await cartUseCase.deleteFromCart(cartId);
  //   result.fold(
  //     (failure) => state = state.copyWith(isLoading: false, error: failure.error),
  //     (isDeleted) {
  //       state = state.copyWith(isLoading: false);
  //       fetchCartByUser();
  //     },
  //   );
  // }
}
