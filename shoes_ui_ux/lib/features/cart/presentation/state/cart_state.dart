import 'package:sneakers_point/features/cart/domain/entity/cart_entity.dart';

class CartState {
  final bool isLoading;
  final List<ProductInCartEntity> carts;
  final bool showMessage;
  final String? error;

  CartState({
    required this.isLoading,
    required this.carts,
    required this.showMessage,
    required this.error,
  });

  factory CartState.initialState() {
    return CartState(
      isLoading: false,
      carts: [],
      showMessage: false,
      error: "",
    );
  }

  CartState copyWith({
    bool? isLoading,
    List<ProductInCartEntity>? carts,
    bool? showMessage,
    String? error,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      carts: carts ?? this.carts,
      showMessage: showMessage ?? this.showMessage,
      error: error ?? this.error,
    );
  }
}
