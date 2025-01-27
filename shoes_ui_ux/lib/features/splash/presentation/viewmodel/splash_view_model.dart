import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sneakers_point/config/router/app_route.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';

final splashViewModelProvider = StateNotifierProvider<SplashViewModel, void>(
  (ref) {
    return SplashViewModel(
      ref.read(userSharedPrefsProvider),
    );
  },
);

class SplashViewModel extends StateNotifier<void> {
  final UserSharedPrefs _userSharedPrefs;
  SplashViewModel(this._userSharedPrefs) : super(null);

  init(BuildContext context) async {
    final data = await _userSharedPrefs.getUserToken();

    data.fold((l) => null, (token) async {
      if (token != null) {
        bool isTokenExpired = isValidToken(token);
        if (isTokenExpired) {
          Navigator.popAndPushNamed(context, AppRoute.loginRoute);
        } else {
          final isAdmin = await _userSharedPrefs.getIsAdmin();
          isAdmin.fold(
            (failure) =>
                Navigator.popAndPushNamed(context, AppRoute.loginRoute),
            (isAdminValue) {
              if (isAdminValue) {
                Navigator.popAndPushNamed(context, AppRoute.adminHomeRoute);
              } else {
                Navigator.popAndPushNamed(context, AppRoute.userHomeRoute);
              }
            },
          );
        }
      } else {
        Navigator.popAndPushNamed(context, AppRoute.loginRoute);
      }
    });

    // data.fold((l) => null, (token) {
    //   if (token != null) {
    //     bool isTokenExpired = isValidToken(token);
    //     if (isTokenExpired) {
    //       // We will not do navigation like this,
    //       // we will use mixin and navigator class for this
    //       Navigator.popAndPushNamed(context, AppRoute.loginRoute);
    //     } else {
    //       Navigator.popAndPushNamed(context, AppRoute.userHomeRoute);
    //     }
    //   } else {
    //     Navigator.popAndPushNamed(context, AppRoute.loginRoute);
    //   }
    // });
  }

  bool isValidToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    // 10 digit
    int expirationTimestamp = decodedToken['exp'];
    // 13
    final currentDate = DateTime.now().millisecondsSinceEpoch;
    // If current date is greater than expiration timestamp then token is expired
    return currentDate > expirationTimestamp * 1000;
  }
}
