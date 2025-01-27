import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/features/product/domain/entity/product_entity.dart';
import 'package:sneakers_point/features/product/presentation/state/product_state.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';
import 'package:sneakers_point/features/user_home/presentation/view_model/home_view_model.dart';
import 'package:sneakers_point/features/user_home/presentation/widget/product_widget.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  double _proximityValue = 0;
  late TextEditingController _searchController;
  final List<StreamSubscription<dynamic>> _streamSubscription =
      <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    _streamSubscription.add(proximityEvents!.listen((event) {
      setState(() {
        _proximityValue = event.proximity;
        if (_proximityValue == 0) {
          ref.read(userHomeViewModelProvider.notifier).logout(context);
        }
      });
    }));
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);

    // return Scaffold(
    // appBar: AppBar(
    //   title: const Text(
    //     'Meat Shop',
    //     style: TextStyle(color: Colors.white),
    //   ),
    //   actions: [
    //     IconButton(
    //       onPressed: () {
    //         showSnackBar(message: 'Refreshing...', context: context);
    //       },
    //       icon: const Icon(
    //         Icons.refresh,
    //         color: Colors.white,
    //       ),
    //     ),
    //     _proximityValue != 0
    //         ? IconButton(
    //             onPressed: () {
    //               ref
    //                   .read(userHomeViewModelProvider.notifier)
    //                   .logout(context);
    //             },
    //             icon: const Icon(
    //               Icons.logout,
    //               color: Colors.white,
    //             ),
    //           )
    //         : const SizedBox(), // Empty container if proximity value is not 0
    //     SwitchListTile(
    //       title: const Text('Dark Mode'),
    //       value: true,
    //       onChanged: (value) {},
    //       activeColor: Colors.green, // Change the active color
    //       inactiveTrackColor: Colors.grey, // Change the inactive track color
    //       activeTrackColor:
    //           Colors.lightGreen, // Change the active track color
    //       inactiveThumbColor: Colors.grey, // Change the inactive thumb color
    //     ),
    //   ],
    // ),
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search products',
              labelStyle: const TextStyle(fontSize: 13),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.green),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                  ref
                      .read(productViewModelProvider.notifier)
                      .clearFilteredProducts(productState.products);
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            onChanged: (value) {
              ref.read(productViewModelProvider.notifier).searchProduct(value);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "All Products",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: ProductWidget(
            ref: ref,
            productList: _getProductList(productState),
          ),
        ),
      ],
    );
  }

  List<ProductEntity> _getProductList(ProductState productState) {
    return _searchController.text.isNotEmpty
        ? productState.filteredProducts
        : productState.products;
  }
}
