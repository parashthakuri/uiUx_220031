import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:sneakers_point/config/router/app_route.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';
import 'package:sneakers_point/features/auth/domain/usecase/auth_use_case.dart';
import 'package:sneakers_point/features/auth/presentation/state/auth_state.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
    ref.read(authUseCaseProvider),
    ref.read(userSharedPrefsProvider),
  ),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.authUseCase, this.userSharedPrefs)
      : super(AuthState.initialState()) {
    getAllUser();
  }

  final UserSharedPrefs userSharedPrefs;
  final AuthUseCase authUseCase;

  final Logger logger = Logger();

  Future<void> registerUser(BuildContext context, AuthEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.register(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: "Successfully registered", context: context);
      },
    );
  }

  Future<void> loginUser(
    BuildContext context,
    String username,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.login(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (success) async {
        state = state.copyWith(isLoading: false, error: null);

        logger.d("login ???: $success");
        // Retrieve isAdmin status from SharedPreferences
        var isAdminResult = await userSharedPrefs.getIsAdmin();
// Inside your method where you retrieve isAdmin
        logger.d('isAdmin value: $isAdminResult');

        isAdminResult.fold(
          (failure) {
            // Handle failure case
            showSnackBar(
                message: failure.error, context: context, color: Colors.red);
          },
          (isAdmin) {
            // Navigate to appropriate route based on isAdmin status
            if (isAdmin) {
              showSnackBar(message: "Admin success", context: context);
              Navigator.pushReplacementNamed(context, AppRoute.adminHomeRoute);
            } else {
              showSnackBar(message: "User success", context: context);
              Navigator.pushReplacementNamed(context, AppRoute.userHomeRoute);
            }
          },
        );
      },
    );
  }

  Future<void> getUserById(BuildContext context) async {
    state = state.copyWith(isLoading: true);

    // Extract userId from Either<Failure, String>
    final userId = await _getUserIdFromSharedPrefs();
    var data = await authUseCase.getUserById(userId);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (user) {
        state = state.copyWith(isLoading: false, user: user, error: null);
      },
    );
  }

  Future<String> _getUserIdFromSharedPrefs() async {
    final userIdEither = await userSharedPrefs.getUserId();
    return userIdEither.fold(
      (failure) {
        // Log error and return default user ID
        logger.e('Failed to get user ID from shared preferences: $failure');
        return 'default_user_id';
      },
      (userId) => userId!,
    );
  }

  getAllUser() async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.getAllUser();

    logger.d('All user: $data');

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, users: r, error: null),
    );
  }

  Future<void> updateProfile(BuildContext context, String email,
      String firstName, String lastName, String userId) async {
    state = state.copyWith(isLoading: true);
    final result =
        await authUseCase.updateProfile(email, firstName, lastName, userId);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
            message: failure.error, context: context, color: Colors.red);
      },
      (_) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(message: 'Profile updated successfully', context: context);
      },
    );
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:logger/logger.dart';
// import 'package:sneakers_point/config/router/app_route.dart';
// import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
// import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
// import 'package:sneakers_point/features/auth/data/dto/get_user_by_id_dto.dart';
// import 'package:sneakers_point/features/auth/domain/entity/auth_entity.dart';
// import 'package:sneakers_point/features/auth/domain/usecase/get_all_user_usecase.dart';
// import 'package:sneakers_point/features/auth/domain/usecase/get_user_by_id_usecase.dart';
// import 'package:sneakers_point/features/auth/domain/usecase/login_usecase.dart';
// import 'package:sneakers_point/features/auth/domain/usecase/register_usecase.dart';
// import 'package:sneakers_point/features/auth/domain/usecase/update_usecase.dart';
// import 'package:sneakers_point/features/auth/presentation/state/auth_state.dart';

// final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
//   (ref) => AuthViewModel(
//     ref.read(registerUseCaseProvider),
//     ref.read(loginUseCaseProvider),
//     ref.read(userSharedPrefsProvider),
//     ref.read(getUserIdUseCaseProvider),
//     ref.read(updateProfileUseCaseProvider),
//     ref.read(getAllUserUseCaseProvider),
//   ),
// );

// class AuthViewModel extends StateNotifier<AuthState> {
//   AuthViewModel(this.registerUseCase, this.loginUseCase, this.userSharedPrefs, this.getUserIdUseCase,this.updateProfileUseCase,
//       this.getAllUserUseCase)
//       : super(AuthState.initialState()) {
//     getAllUser();
//   }

//   final UserSharedPrefs userSharedPrefs;
//   final RegisterUseCase registerUseCase;
//   final LoginUseCase loginUseCase;
//   final GetAllUserUseCase getAllUserUseCase;
//   final GetUserIdUseCase getUserIdUseCase;
//   final UpdateProfileUseCase updateProfileUseCase;

//   final Logger logger = Logger();

//   Future<void> register(BuildContext context, AuthEntity user) async {
//     state = state.copyWith(isLoading: true);
//     var data = await registerUseCase.addUser(user);
//     data.fold(
//       (failure) {
//         state = state.copyWith(
//           isLoading: false,
//           error: failure.error,
//         );
//         showSnackBar(
//             message: failure.error, context: context, color: Colors.red);
//       },
//       (success) {
//         state = state.copyWith(isLoading: false, error: null);
//         showSnackBar(message: "Successfully registered", context: context);
//       },
//     );
//   }

//   Future<void> login(
//     BuildContext context,
//     String username,
//     String password,
//   ) async {
//     state = state.copyWith(isLoading: true);
//     var data = await loginUseCase.login(username, password);
//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         showSnackBar(
//             message: failure.error, context: context, color: Colors.red);
//       },
//       (success) async {
//         state = state.copyWith(isLoading: false, error: null);

//         logger.d("login ???: $success");
//         // Retrieve isAdmin status from SharedPreferences
//         var isAdminResult = await userSharedPrefs.getIsAdmin();
// // Inside your method where you retrieve isAdmin
//         logger.d('isAdmin value: $isAdminResult');

//         isAdminResult.fold(
//           (failure) {
//             // Handle failure case
//             showSnackBar(
//                 message: failure.error, context: context, color: Colors.red);
//           },
//           (isAdmin) {
//             // Navigate to appropriate route based on isAdmin status
//             if (isAdmin) {
//               showSnackBar(message: "Admin success", context: context);
//               Navigator.pushReplacementNamed(context, AppRoute.adminHomeRoute);
//             } else{
//               showSnackBar(message: "User success", context: context);
//               Navigator.pushReplacementNamed(context, AppRoute.userHomeRoute);
//             }
//           },
//         );
//       },
//     );
//   }

//     Future<void> getUserById(BuildContext context) async {
//     state = state.copyWith(isLoading: true);

//     // Extract userId from Either<Failure, String>
//   final userId = await _getUserIdFromSharedPrefs();
//     var data = await getUserIdUseCase.getUserById(userId);

//     data.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         showSnackBar(
//             message: failure.error, context: context, color: Colors.red);
//       },
//       (user) {
//         state = state.copyWith(isLoading: false, user: user, error: null);
//       },
//     );
//   }

//   Future<String> _getUserIdFromSharedPrefs() async {
//   final userIdEither = await userSharedPrefs.getUserId();
//   return userIdEither.fold(
//     (failure) {
//       // Log error and return default user ID
//       logger.e('Failed to get user ID from shared preferences: $failure');
//       return 'default_user_id';
//     },
//     (userId) => userId!,
//   );
// }

//   getAllUser() async {
//     state = state.copyWith(isLoading: true);
//     var data = await getAllUserUseCase.getAllUser();

//     logger.d('All user: $data');

//     data.fold(
//       (l) => state = state.copyWith(isLoading: false, error: l.error),
//       (r) => state = state.copyWith(isLoading: false, users: r, error: null),
//     );
//   }


//  Future<void> updateProfile(BuildContext context, String email, String firstName, String lastName, String userId) async {
//     state = state.copyWith(isLoading: true);
//     final result = await updateProfileUseCase.updateProfile(email, firstName, lastName,  userId);
//     result.fold(
//       (failure) {
//         state = state.copyWith(isLoading: false, error: failure.error);
//         showSnackBar(message: failure.error, context: context, color: Colors.red);
//       },
//       (_) {
//         state = state.copyWith(isLoading: false, error: null);
//         showSnackBar(message: 'Profile updated successfully', context: context);
//       },
//     );
//   }
//   // Future<void> login(
//   //     BuildContext context, String username, String password) async {
//   //   state = state.copyWith(isLoading: true);
//   //   final result = await loginUseCase.login(username, password);
//   //   state = state.copyWith(isLoading: false);
//   //   result.fold(
//   //     (failure) => state = state.copyWith(
//   //       error: failure.error,
//   //       showMessage: true,
//   //     ),
//   //     (success) async {
//   //       state = state.copyWith(
//   //         isLoading: false,
//   //         showMessage: true,
//   //         error: null,
//   //       );
//   //             Navigator.popAndPushNamed(context, AppRoute.adminHomeRoute);

//   //       // Check isAdmin status after successful login
//   //       final isAdminResult = await userSharedPrefs.getIsAdmin();
//   //       isAdminResult.fold(
//   //         (failure) {
//   //           // Handle failure case
//   //           // You might want to show an error message or log the error
//   //          state = state.copyWith(
//   //       error: failure.error,
//   //       showMessage: true,
//   //     );
//   //         },
//   //         (isAdmin) {
//   //           if (isAdmin) {
//   //             Navigator.popAndPushNamed(context, AppRoute.adminHomeRoute);
//   //           } else {
//   //             Navigator.popAndPushNamed(context, AppRoute.userHomeRoute);
//   //           }
//   //         },
//   //       );
//   //     },
//   //   );
//   // }

//   void reset() {
//     state = state.copyWith(
//       isLoading: false,
//       error: null,
//       showMessage: false,
//     );
//   }
// }
