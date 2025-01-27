import 'package:flutter/material.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/cart_page_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/profile_view.dart';
import 'package:sneakers_point/features/product/presentation/view/all_product_view.dart';

class HomeState {
  final int index;
  final List<Widget> lstScreen;

  HomeState({required this.index, required this.lstScreen});

  HomeState.initialState()
      : index = 0,
        lstScreen = [
          const DashboardView(),
          const CartPageView(),
          const ProfileView(),
        ];

  HomeState copyWith({
    int? index,
  }) {
    return HomeState(index: index ?? this.index, lstScreen: lstScreen);
  }
}
