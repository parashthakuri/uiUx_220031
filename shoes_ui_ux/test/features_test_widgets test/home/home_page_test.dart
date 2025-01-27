import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sneakers_point/config/router/app_route.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/domain/use_case/product_usecase.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';
import 'package:mockito/mockito.dart';

import '../../../test_data/product_entity_test.dart';
import '../../unit_test/product_unit_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProductuseCase mockProductUseCase;
  late List<ProductEntity> lstProductEntity;

  setUpAll(() async {
    mockProductUseCase = MockProductuseCase();
    lstProductEntity =
        await getAllProductTest(); // Use getProductList() instead of getAllProductTest()
  });

  testWidgets(
    'Dashboard View Test',
    (WidgetTester tester) async {
      // Mocking ProductUseCase
      when(mockProductUseCase.getAllProduct())
          .thenAnswer((_) async => Right(lstProductEntity));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productViewModelProvider
                .overrideWith((ref) => ProductViewModel(mockProductUseCase)),
          ],
          child: MaterialApp(
            routes: AppRoute.getApplicationRoute(),
            initialRoute: AppRoute.userHomeRoute,
          ),
        ),
      );

      // Wait for the widgets to settle
      await tester.pumpAndSettle();

      // Verify that there are two GridView widgets
      expect(find.byType(GridView), findsNWidgets(2));
    },
  );
}
