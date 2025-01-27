import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';

class ProductState {
  final bool isLoading;
  final List<ProductEntity> products;
  final List<ProductEntity> filteredProducts; // Add filteredProducts property
  final ProductEntity singleProduct;
  final bool hasReachedMax;
  final int page;
  final bool showMessage;
  final bool showProductDeleteMessage;
  final String? error;

  ProductState({
    required this.showProductDeleteMessage,
    required this.isLoading,
    required this.products,
    required this.filteredProducts, // Initialize filteredProducts
    required this.singleProduct,
    required this.hasReachedMax,
    required this.page,
    required this.showMessage,
    required this.error,
  });

  factory ProductState.initialState() {
    return ProductState(
      isLoading: false,
      products: [],
      showProductDeleteMessage: false,
      filteredProducts: [], // Initialize filteredProducts
      singleProduct: ProductEntity.empty(),
      hasReachedMax: false,
      page: 0,
      showMessage: false,
      error: "",
    );
  }

  ProductState copyWith({
    bool? isLoading,
    List<ProductEntity>? products,
    ProductEntity? singleProduct,
    List<ProductEntity>?
        filteredProducts, // Update singleProduct type to ProductEntity
    bool? hasReachedMax,
    int? page,
    bool? showMessage,
    bool? showProductDeleteMessage,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      singleProduct: singleProduct ?? this.singleProduct,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      showMessage: showMessage ?? this.showMessage,
      showProductDeleteMessage:
          showProductDeleteMessage ?? this.showProductDeleteMessage,
      error: error ?? this.error,
    );
  }
}
