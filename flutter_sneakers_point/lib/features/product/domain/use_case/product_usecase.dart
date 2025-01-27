import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/domain/repository/product_repository.dart';

final productuseCaseProvider = Provider<ProductuseCase>(
  (ref) =>
      ProductuseCase(productRepository: ref.read(productRepositoryProvider)),
);

class ProductuseCase {
  final ProductRepository productRepository;

  ProductuseCase({required this.productRepository});

  Future<Either<Failure, bool>> addProduct(
      ProductEntity productEntity, File? img) async {
    return await productRepository.addProduct(productEntity, img);
  }

  Future<Either<Failure, bool>> deleteProduct(String id) async {
    return await productRepository.deleteProduct(id);
  }

  Future<Either<Failure, List<ProductEntity>>> getAllProduct() async {
    return await productRepository.getAllProduct();
  }

  Future<Either<Failure, ProductEntity>> getProductById(
      String productId) async {
    return await productRepository.getSingleProductById(productId);
  }

  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      String query) async {
    return await productRepository.searchProducts(query);
  }
}
