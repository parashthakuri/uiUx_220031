import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sneakers_point/features/admin_home/presentation/view/bottom_view/admin_dashboard_view.dart';
import 'package:sneakers_point/features/admin_home/presentation/view/bottom_view/all_users_view.dart';
import 'package:sneakers_point/features/category/presentation/view/category_add.dart';
import 'package:sneakers_point/features/product/presentation/view/admin_add_view.dart';

class AdminHomeView extends ConsumerStatefulWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  _AdminHomeViewState createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends ConsumerState<AdminHomeView> {
  int selectedIndex = 0;
  List<Widget> lstScreen = const [
    AdminDashbaordView(),
    AdminAddProduct(),
    AdminAddCategory(),
    AllUserView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 8, 43, 17),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.folderPlus),
            label: 'Collections',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.plusCircle),
            label: 'Variety',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            label: 'User',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 138, 129, 129),
        unselectedItemColor: Colors.grey[300], // Light grey color
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
