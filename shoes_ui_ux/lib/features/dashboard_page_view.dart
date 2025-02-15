import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sneakers_point/features/cart/presentation/view/cart_view.dart';
import 'package:sneakers_point/features/user_home/presentation/view/bottom_view/cart_page_view.dart';

import 'home_page_view.dart';

class DashboardPageView extends StatefulWidget {
  const DashboardPageView({Key? key}) : super(key: key);

  @override
  _DashboardPageViewState createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  PageController pageController = PageController();
  int selectedIndex = 0;

  _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  _itemTapped(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFf5f5f4),
        body: PageView(
          controller: pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Widget>[
            HomeScreen(),
            CartPageView(),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 14, 95, 14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GNav(
              backgroundColor: const Color.fromARGB(255, 14, 95, 14),
              color: Colors.white,
              activeColor: const Color.fromARGB(255, 31, 79, 56),
              tabBackgroundColor: Colors.white,
              gap: 8,
              padding: const EdgeInsets.all(16),
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                _itemTapped(index);
                setState(() {
                  selectedIndex = index;
                });
              },
              tabs: const [
                GButton(icon: Icons.home, text: 'Home'),
                GButton(icon: Icons.shopping_cart, text: 'Cart'),
                GButton(icon: Icons.favorite_border, text: 'Favorite'),
                GButton(icon: Icons.verified_user_outlined, text: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
