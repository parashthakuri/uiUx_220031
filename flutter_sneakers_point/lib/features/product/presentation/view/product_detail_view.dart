import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_point/config/router/app_route.dart';
import 'package:sneakers_point/core/common/snackbar/my_snackbar.dart';
import 'package:sneakers_point/core/shared_prefs/user_shared_prefs.dart';
import 'package:sneakers_point/features/cart/presentation/viewmodel/cart_view_model.dart';
import 'package:sneakers_point/features/product/presentation/view_model/product_view_model.dart';

class ProductDetailView extends ConsumerStatefulWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productViewModelProvider);
    var userSharedPrefs = ref.watch(userSharedPrefsProvider);
    final cartState = ref.watch(cartViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cartState.showMessage) {
        showSnackBar(message: 'Cart Added', context: context);
        ref.read(cartViewModelProvider.notifier).resetMessage(false);
      }
      // if(cartState.showErrorMessage){
      //   showSnackBar(message: 'Cart failed', context: context);
      //   ref.read(cartViewModelProvider.notifier).resetMessage(false);
      // }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          IconButton(
            onPressed: () {
              // Handle share functionality
            },
            icon: const Icon(
              Icons.share,
              color: Colors.blue,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (productState.isLoading) ...{
                const CircularProgressIndicator(),
              } else if (productState.singleProduct.productId == null) ...{
                const Center(
                  child: Text('No Product Found'),
                ),
              } else ...{
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Image.network(
                        productState.singleProduct.productImageUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                                'Category: ${productState.singleProduct.productCategory}',
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Text(
                    productState.singleProduct.productName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    'Description: ${productState.singleProduct.productDescription}',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Price: \$${productState.singleProduct.productPrice}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 4.0,
                  direction: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        // Show a snackbar when button is pressed
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Add to cart success'),
                        //     duration: Duration(seconds: 2),
                        //   ),
                        // );

                        showSnackBar(
                            message: "Admin success", context: context);

                        Navigator.pushNamed(context, AppRoute.cartRoute);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12.0)),
                        width: 200,
                        child: const ListTile(
                          title: Text(
                            "Add to cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          trailing: Icon(Icons.shopping_bag),
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     const Text(
                    //       "Cart",
                    //       style: TextStyle(fontWeight: FontWeight.bold),
                    //     ),
                    //     const SizedBox(
                    //       width: 20,
                    //     ),
                    //     OutlinedButton(
                    //       onPressed: () async {
                    //         final userIdResult =
                    //             await userSharedPrefs.getUserId();
                    //         userIdResult.fold(
                    //           (failure) =>
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //             SnackBar(
                    //               content: Text(failure.error),
                    //             ),
                    //           ),
                    //           (userId) {
                    //             CartEntity cart = CartEntity(
                    //               user:
                    //                   userId!, // Replace with the actual user ID
                    //               products: [
                    //                 ProductInCartEntity(
                    //                   product: productState.singleProduct
                    //                       .productId!, // Use the product ID
                    //                   quantity:
                    //                       1, // Assuming you are adding 1 quantity each time
                    //                 ),
                    //               ],
                    //             );

                    //             ref
                    //                 .read(cartViewModelProvider.notifier)
                    //                 .addToCart(cart);
                    //           },
                    //         );
                    //       },
                    //       child: const Icon(Icons.shop_2_outlined),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
