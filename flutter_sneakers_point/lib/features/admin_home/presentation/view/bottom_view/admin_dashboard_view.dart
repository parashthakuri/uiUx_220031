import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/features/admin_home/presentation/viewmodel/home_viewmodel.dart';
import 'package:sneakers_point/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:sneakers_point/features/category/presentation/view_model/category_view_model.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';

class AdminDashbaordView extends ConsumerStatefulWidget {
  const AdminDashbaordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminDashbaordViewState();
}

class _AdminDashbaordViewState extends ConsumerState<AdminDashbaordView> {
  @override
  Widget build(BuildContext context) {
    var productState = ref.watch(productViewModelProvider);
    var userState = ref.watch(authViewModelProvider);
    var categoryState = ref.watch(categoryViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard View'),
        actions: [
          IconButton(
            onPressed: () {
              // ref.read(batchViewModelProvider.notifier).getBatches();
              // ref.read(courseViewModelProvider.notifier).getCourses();
              showSnackBar(message: 'Refressing...', context: context);
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(adminHomeViewModelProvider.notifier).logout(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                width: screenWidth * 0.9, // 90% of screen width
                height: screenHeight * 0.2,
                child: Card(
                  color: Color.fromARGB(255, 28, 92, 20),
                  child: Center(
                    child: Text(
                      'Total Products: ${productState.products.length}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Users',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                width: screenWidth * 0.9, // 90% of screen width
                height: screenHeight * 0.2,
                child: Card(
                  color: Color.fromARGB(255, 41, 77, 13),
                  child: Center(
                    child: Text(
                      'Total Users ${userState.users?.length}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Categories',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Flexible(
              child: SizedBox(
                width: screenWidth * 0.9, // 90% of screen width
                height: screenHeight * 0.2,
                child: Card(
                  color: Color.fromARGB(255, 20, 115, 61),
                  child: Center(
                    child: Text(
                      'Total Categories ${categoryState.categories.length}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
// import 'package:sneakers_point/features/home/presentation/view_model/home_view_model.dart';

// import '../../widget/course_widget.dart';

// class AdminDashboard extends ConsumerStatefulWidget {
//   const AdminDashboard({super.key});

//   @override
//   ConsumerState<AdminDashboard> createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends ConsumerState<AdminDashboard> {
//   late bool isDark;
//   @override
//   void initState() {
//     isDark = ref.read(isDarkThemeProvider);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var batchState = ref.watch(batchViewModelProvider);
//     var courseState = ref.watch(courseViewModelProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard View'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               // ref.read(batchViewModelProvider.notifier).getBatches();
//               // ref.read(courseViewModelProvider.notifier).getCourses();
//               showSnackBar(message: 'Refressing...', context: context);
//             },
//             icon: const Icon(
//               Icons.refresh,
//               color: Colors.white,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               ref.read(homeViewModelProvider.notifier).logout(context);
//             },
//             icon: const Icon(
//               Icons.logout,
//               color: Colors.white,
//             ),
//           ),
//           Switch(
//               value: isDark,
//               onChanged: (value) {
//                 setState(() {
//                   isDark = value;
//                   ref.read(isDarkThemeProvider.notifier).updateTheme(value);
//                 });
//               }),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Batches',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             // Flexible(
//             //   child: BatchWidget(ref: ref, batchList: batchState.batches),
//             // ),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'Courses',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Flexible(
//               child: CourseWidget(courseList: courseState.courses),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
