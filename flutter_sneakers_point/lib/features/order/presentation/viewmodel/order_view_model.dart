import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';

final orderViewModelProvider = StateNotifierProvider<OrderViewModel, bool>(
  (ref) => OrderViewModel(
    ref.read(userSharedPrefsProvider),
  ),
);

class OrderViewModel extends StateNotifier<bool> {
  final UserSharedPrefs _userSharedPrefs;
  OrderViewModel(this._userSharedPrefs) : super(false);
}
