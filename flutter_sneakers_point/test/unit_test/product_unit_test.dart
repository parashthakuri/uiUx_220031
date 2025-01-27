import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/domain/use_case/product_usecase.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_data/product_entity_test.dart';
import 'product_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ProductuseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late ProductuseCase mockProductUseCase;
  late List<ProductEntity> lstProductEntity;

  setUpAll(() async {
    mockProductUseCase = MockProductuseCase();
    lstProductEntity = await getAllProductTest();
    when(mockProductUseCase.getAllProduct())
        .thenAnswer((_) async => const Right([]));
    container = ProviderContainer(
      overrides: [
        productViewModelProvider.overrideWith(
          (ref) => ProductViewModel(mockProductUseCase),
        ),
      ],
    );
  });

  test('check product initial state', () async {
    await container.read(productViewModelProvider.notifier).getAllProduct();

    final productState = container.read(productViewModelProvider);

    expect(productState.isLoading, false);
    expect(productState.products, isEmpty);
    expect(productState.showMessage, isEmpty);
  });

  test('check for the list of products when calling getAllProducts', () async {
    when(mockProductUseCase.getAllProduct())
        .thenAnswer((_) => Future.value(Right(lstProductEntity)));

    await container.read(productViewModelProvider.notifier).getAllProduct();

    final productState = container.read(productViewModelProvider);

    expect(productState.isLoading, false);
    expect(productState.products.length, 5);
  });

  test('add product entity and return true if successfully added', () async {
    when(mockProductUseCase.addProduct(lstProductEntity[0], null))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(productViewModelProvider.notifier)
        .addProduct(lstProductEntity[0], null);

    final productState = container.read(productViewModelProvider);

    expect(productState.showMessage, isNull);
  });

  test('add product entity and return false if an error occur', () async {
    when(mockProductUseCase.addProduct(lstProductEntity[0], null))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Not added'))));

    await container
        .read(productViewModelProvider.notifier)
        .addProduct(lstProductEntity[0], null);

    final productState = container.read(productViewModelProvider);

    expect(productState.showMessage, isNotNull);
  });

  tearDownAll(() {
    container.dispose();
  });
}
