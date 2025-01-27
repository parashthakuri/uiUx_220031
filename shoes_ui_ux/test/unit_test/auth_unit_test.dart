import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sneakers_point/core/failure/failure.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';
import 'package:sneakers_point/features/auth/domain/usecase/auth_use_case.dart';
import 'package:sneakers_point/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_unit_test.mocks.dart';

//dart run build_runner build --delete-conflicting-outputs

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<BuildContext>(),
])
//the above is used to make a duplicate(nakali) function of above used class AuthUseCase
void main() {
  late AuthUseCase mockAuthUseCase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockAuthUseCase = MockAuthUseCase();
    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith((ref) =>
            AuthViewModel(mockAuthUseCase, mockAuthUseCase as UserSharedPrefs)),

        //aarun provider harulai pani added garne for testing
      ],
    );
  });

  test('check for the initial state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.showMessage, isNull);
  });

  test('login test with valid username and password', () async {
    when(mockAuthUseCase.login('deep', 'deep'))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'deep', 'deep');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('check for invalid username and password ', () async {
    when(mockAuthUseCase.login('deep', 'deep'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .loginUser(context, 'deep', 'deep');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  test('register test with valid data', () async {
    const mockUser = AuthEntity(
      firstName: 'deep',
      lastName: 'deep',
      email: 'deep@gmail.com',
      password: 'deep',
    );

    when(mockAuthUseCase.register(mockUser))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(context, mockUser);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('register test with invalid data', () async {
    const mockUser = AuthEntity(
      firstName: 'Doe', // invalid data
      lastName: 'Doe',
      email: 'john.doe@example.com',
      password: 'password123',
    );

    when(mockAuthUseCase.register(mockUser))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid data'))));

    await container
        .read(authViewModelProvider.notifier)
        .registerUser(context, mockUser);

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid data');
  });

  tearDownAll(
    () => container.dispose(),
  );
}
