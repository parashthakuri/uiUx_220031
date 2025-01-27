// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:groceryapp/config/routers/app_routes.dart';
// import 'package:groceryapp/features/auth/domain/usecases/auth_usecase.dart';
// import 'package:groceryapp/features/auth/presentation/viewmodel/auth_viewmodel.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import '../../unit_test/auth_unit_test.mocks.dart';


// @GenerateNiceMocks([
//   MockSpec<AuthUseCase>(),

// ])
// void main() {
//   late AuthUseCase mockAuthUsecase;
//   late bool isLogin;

//   setUpAll(() async {
//     mockAuthUsecase = MockAuthUseCase();
//     isLogin = true;
//   });

//   testWidgets('login test with username and password and view dashboard',
//       (WidgetTester tester) async {
//     when(mockAuthUsecase.loginUser('deep', 'deep'))
//         .thenAnswer((_) async => Right(isLogin));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           authViewModelProvider
//               .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
//         ],
//         child: MaterialApp(
//           initialRoute: AppRoute.loginRoute,
//           routes: AppRoute.getApplicationRoute(),
//         ),
//       ),
//     );
//     await tester.pumpAndSettle();


//     await tester.enterText(find.byType(TextField).at(0), 'deep');
//     await tester.enterText(find.byType(TextField).at(1), 'deep');

//     await tester.tap(
//       find.widgetWithText(ElevatedButton, 'Login'),
//     );

//     await tester.pumpAndSettle();

//     expect(find.text('Dashboard'), findsOneWidget);
//   });
// }
