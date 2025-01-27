// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:groceryapp/config/routers/app_routes.dart';
// import 'package:groceryapp/features/auth/domain/entities/auth_entities.dart';
// import 'package:groceryapp/features/auth/domain/usecases/auth_usecase.dart';
// import 'package:groceryapp/features/auth/presentation/viewmodel/auth_viewmodel.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import '../../unit_test/auth_unit_test.mocks.dart';

// @GenerateNiceMocks([
//   MockSpec<AuthUseCase>(),
// ])
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   late AuthUseCase mockAuthUsecase;
//   late AuthEntity authEntity;

//   setUpAll(() async {
//     mockAuthUsecase = MockAuthUseCase();
//     authEntity = const AuthEntity(
//       userId: null,
//       firstName: 'sandeep',
//       lastName: 'sandeep',
//       email: 'sandeep@gmail.com',
//       password: 'sandeep',
//     );
//   });

//   testWidgets('View Register ...', (tester) async {
//     when(mockAuthUsecase.registerUser(authEntity))
//         .thenAnswer((_) async => const Right(true));

//     await tester.pumpWidget(
//       ProviderScope(
//         overrides: [
//           authViewModelProvider.overrideWith(
//             (ref) => AuthViewModel(mockAuthUsecase),
//           ),
//         ],
//         child: MaterialApp(
//           initialRoute: AppRoute.signRoute,
//           routes: AppRoute.getApplicationRoute(),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     await tester.enterText(find.byType(TextFormField).at(0), 'sandeep');
//     await tester.enterText(find.byType(TextFormField).at(1), 'sandeep');
//     await tester.enterText(find.byType(TextFormField).at(2), 'sandeep@gmail.com');
//     await tester.enterText(find.byType(TextFormField).at(3), 'sandeep');
//     await tester.enterText(find.byType(TextFormField).at(4), 'sandeep');

//     //=========================== Find the register button===========================
//     final registerButtonFinder = find.widgetWithText(ElevatedButton, 'SignUp');

//     await tester.tap(registerButtonFinder);

//     await tester.pumpAndSettle(const Duration(seconds: 2));

//   });
// }
