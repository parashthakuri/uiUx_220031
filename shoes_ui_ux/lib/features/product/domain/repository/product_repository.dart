import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/product/data/repository/product_remote_repository.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) {
    return ref.read(productRemoteRepositoryProvider);

    // if (ref.watch(connectivityStatusProvider) ==
    //     ConnectivityStatus.isConnected) {
    //   return ref.read(productRemoteRepositoryProvider);
    // } else {
    //   return ref.read(productLocalRepositoryProvider);
    // }
  },
);

abstract class ProductRepository {
  Future<Either<Failure, bool>> addProduct(ProductEntity product, File? img);
  Future<Either<Failure, List<ProductEntity>>> getAllProduct();
  Future<Either<Failure, ProductEntity>> getSingleProductById(String productId);
  Future<Either<Failure, bool>> deleteProduct(String id);
  Future<Either<Failure, bool>> editProduct(String id);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
}
