import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/config/router/app_route.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';

final userHomeViewModelProvider =
    StateNotifierProvider<UserHomeViewModel, bool>(
  (ref) => UserHomeViewModel(
    ref.read(userSharedPrefsProvider),
  ),
);

class UserHomeViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  UserHomeViewModel(this._userSharedPrefs) : super(false);

  void logout(BuildContext context) async {
    state = true;
    showSnackBar(
        message: 'Logging out....', context: context, color: Colors.red);

    await _userSharedPrefs.deleteUserToken();
    Future.delayed(const Duration(milliseconds: 2000), () {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoute.loginRoute,
        (route) => false,
      );
    });
  }
}
