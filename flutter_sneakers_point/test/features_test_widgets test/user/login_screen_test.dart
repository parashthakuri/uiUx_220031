// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:groceryapp/config/routers/app_routes.dart';
// import 'package:groceryapp/features/auth/domain/usecase/auth_usecase.dart';
// import 'package:groceryapp/features/auth/presentation/view_model/auth_view_model.dart';
// import 'package:groceryapp/features/product/domain/entity/product_entity.dart';
// import 'package:groceryapp/features/product/domain/use_case/product_usecase.dart';
// import 'package:groceryapp/features/product/presentation/view_model/product_view_model.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import '../../../test_data/product_entity_test.dart';
// import '../../unit_test/auth_unit_test.mocks.dart';
// import '../../unit_test/product_unit_test.mocks.dart';

// class MockHttpClient extends Mock implements HttpClient {}


// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   late AuthUseCase mockAuthUsecase;
//   late ProductuseCase mockProductUseCase;
//   late List<ProductEntity> lstProductEntity;
//   late bool isLogin;

//   setUpAll(() async {
//     mockAuthUsecase = MockAuthUseCase();
//     mockProductUseCase = MockProductuseCase();
//     lstProductEntity = await getAllProductTest();
//     isLogin = true;
//   });

//   testWidgets('login test with username and password and open dashboard',
//       (WidgetTester tester) async {
//     when(mockAuthUsecase.login('deep', 'deep'))
//         .thenAnswer((_) async => Right(isLogin));

//     when(mockProductUseCase.getAllProduct())
//         .thenAnswer((_) async => Right(lstProductEntity));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           authViewModelProvider
//               .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
//           productViewModelProvider
//               .overrideWith((ref) => ProductViewModel(mockProductUseCase)),
//         ],
//         child: MaterialApp(
//           initialRoute: AppRoute.loginRoute,
//           routes: AppRoute.getApplicationRoute(),
//         ),
//       ),
//     );
//     await tester.pumpAndSettle();
//     await tester.enterText(find.byType(TextFormField).at(0), 'deep');
//     await tester.enterText(find.byType(TextFormField).at(1), 'deep');

//     await tester.tap(
//       find.widgetWithText(ElevatedButton, 'Login'),
//     );

//     await tester.pumpAndSettle(const Duration(seconds: 5));

//     expect(find.text('Dashboard View'), findsOneWidget);
//   });
// }
