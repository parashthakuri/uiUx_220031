import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/cart_page_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/profile_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view_model/home_view_model.dart';

class UserHomeView extends ConsumerStatefulWidget {
  const UserHomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends ConsumerState<UserHomeView> {
  int _selectedIndex = 0;
  final List<Widget> _screens = const [
    DashboardView(),
    CartPageView(),
    ProfileView(),
  ];
  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _fetchUserDataIfNeeded();
    _streamSubscription.add(proximityEvents!.listen((event) {
      setState(() {
        _proximityValue = event.proximity;
        if (_proximityValue == 0) {
          ref.read(userHomeViewModelProvider.notifier).logout(context);
        }
      });
    }));
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meat Shop',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(userHomeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
        // actions: _buildAppBarActions(),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 20, 51, 8),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.car),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 138, 129, 129),
        unselectedItemColor: Colors.grey[300], // Light grey color
        onTap: _onItemTapped,
      ),
    );
  }

  List<Widget> _buildAppBarActions() {
    List<Widget> actions = [
      IconButton(
        onPressed: () {
          showSnackBar(message: 'Refreshing...', context: context);
        },
        icon: const Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
    ];

    if (_proximityValue != 0) {
      actions.add(
        IconButton(
          onPressed: () {
            ref.read(userHomeViewModelProvider.notifier).logout(context);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      );
    } else {
      actions.add(const SizedBox(
        width: 100,
        child: Text("shop"),
      ));
    }

    actions.add(SwitchListTile(
      title: const Text('Dark Mode'),
      value: true,
      onChanged: (value) {},
      activeColor: Colors.green, // Change the active color
      inactiveTrackColor: Colors.grey, // Change the inactive track color
      activeTrackColor: Colors.lightGreen, // Change the active track color
      inactiveThumbColor: Colors.grey, // Change the inactive thumb color
    ));

    return actions;
  }

  void _fetchUserDataIfNeeded() {
    if (_selectedIndex == 2) {
      ref.read(authViewModelProvider.notifier).getUserById(context);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _fetchUserDataIfNeeded();
  }
}
