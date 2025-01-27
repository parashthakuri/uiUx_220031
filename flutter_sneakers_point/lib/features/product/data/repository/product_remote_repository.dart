import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/product/data/data_source/product_remote_data_source.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/domain/repository/product_repository.dart';

final productRemoteRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRemoteRepository(
    productRemoteDataSource: ref.read(productRemoteDataSourceProvider),
  ),
);

class ProductRemoteRepository implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRemoteRepository({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) {
    // TODO: implement deleteProduct
    return productRemoteDataSource.deleteProduct(id);
  }

  @override
  Future<Either<Failure, bool>> editProduct(String id) {
    // TODO: implement editProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProduct() {
    // TODO: implement getAllProduct
    return productRemoteDataSource.getAllProduct();
  }

  @override
  Future<Either<Failure, ProductEntity>> getSingleProductById(
      String productId) {
    // TODO: implement getSingleProductById
    return productRemoteDataSource.getProductById(productId);
  }

  @override
  Future<Either<Failure, bool>> addProduct(ProductEntity product, File? img) {
    // TODO: implement addProduct
    return productRemoteDataSource.addProduct(product, img);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) {
    // TODO: implement searchProducts
    return productRemoteDataSource.searchProducts(query);
  }
}
