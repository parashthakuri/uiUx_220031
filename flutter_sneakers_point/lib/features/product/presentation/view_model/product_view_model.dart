import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sneakers_point/config/router/app_route.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/domain/use_case/product_usecase.dart';
import 'package:sneakers_point/features/product/presentation/state/product_state.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>(
  (ref) => ProductViewModel(
    ref.read(productuseCaseProvider),
  ),
);

class ProductViewModel extends StateNotifier<ProductState> {
  final Logger logger = Logger();
  final ProductuseCase productUsecase;

  ProductViewModel(this.productUsecase) : super(ProductState.initialState()) {
    getAllProduct();
  }

//todo: get all product
  Future<void> getAllProduct() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final products = currentState.products;
    final result = await productUsecase.getAllProduct();
    result.fold(
        (failure) => state =
            state.copyWith(isLoading: false, hasReachedMax: true), (data) {
      if (data.isEmpty) {
        state = state.copyWith(hasReachedMax: true);
      } else {
        state = state.copyWith(
            isLoading: false, products: [...products, ...data], page: page);
        // Navigator.pushNamed(context, AppRoute.allProductRoute)
      }
    });
  }

//todo: get product by id
  Future<void> getProductById(BuildContext context, String batchId) async {
    state = state.copyWith(isLoading: true);
    var data = await productUsecase.getProductById(batchId);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) {
        logger.d('Product details fetched successfully: $r');
        state = state.copyWith(isLoading: false, singleProduct: r, error: null);
        Navigator.pushNamed(context, AppRoute.singleProductRoute);
      },
    );
  }

  //todo: search product
  void searchProduct(String query) async {
    state = state.copyWith(isLoading: true);
    final result = await productUsecase.searchProducts(query);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (products) {
        logger.d('Product details fetched successfully: $products');
        state = state.copyWith(
          isLoading: false,
          filteredProducts: products,
          error: null,
        );
      },
    );
  }

  //todo: empty the filterProduct state empty
  void clearFilteredProducts(List<ProductEntity> products) {
    state = state.copyWith(filteredProducts: products);
  }

//todo: addProduct
  Future<void> addProduct(productEntity, File? img) async {
    state = state.copyWith(isLoading: true);
    final result = await productUsecase.addProduct(productEntity, img);
    result.fold(
      (failure) => state = state.copyWith(isLoading: false),
      (isAdded) {
        state = state.copyWith(isLoading: false, showMessage: true);
        getAllProduct();
      },
    );
  }

//todo: delete product
  Future<void> deleteProduct(id) async {
    state = state.copyWith(isLoading: true);
    final result = await productUsecase.deleteProduct(id);
    result.fold((failure) => state = state.copyWith(isLoading: false),
        (isDeleted) {
      state = state.copyWith(isLoading: false, showProductDeleteMessage: true);
      getAllProduct();
    });
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value, showProductDeleteMessage: value);
  }
}
