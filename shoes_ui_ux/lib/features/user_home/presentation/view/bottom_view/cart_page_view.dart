import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dummy data entity for products in the cart
class ProductInCartEntity {
  final String product;
  final String image;
  final int quantity;

  ProductInCartEntity({
    required this.product,
    required this.quantity,
    required this.image,
  });
}

// Dummy data for Cart ViewModel
final cartViewModelProvider = Provider<CartViewModel>((ref) {
  return CartViewModel();
});

class CartViewModel {
  bool isLoading = false; // Simulate loading state
  List<ProductInCartEntity> carts = [
    ProductInCartEntity(
        product: 'Chicken Breast', image: 'assets/images/c2.png', quantity: 2),
    ProductInCartEntity(
        product: 'Beef Steak', image: 'assets/images/c4.png', quantity: 1),
    ProductInCartEntity(
        product: 'Pork Chops', image: 'assets/images/c3.png', quantity: 3),
  ];
}

class CartPageView extends ConsumerStatefulWidget {
  const CartPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartPageViewState();
}

class _CartPageViewState extends ConsumerState<CartPageView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(cartViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildCartList(viewModel.carts),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show Snackbar when button is pressed
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Proceeding to Checkout...'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        label: const Text('Proceed to Checkout'),
        icon: const Icon(Icons.shopping_cart),
        backgroundColor: Colors.green.shade400,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildCartList(List<ProductInCartEntity> carts) {
    return ListView.builder(
      itemCount: carts.length,
      itemBuilder: (context, index) {
        final quantity = carts[index].quantity;

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                carts[index].image, // Load the image from local assets
                fit: BoxFit.cover,
              ),
            ),
            title: Text(carts[index].product),
            subtitle: Text('Quantity: $quantity'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (carts[index].quantity > 1) {
                        carts[index] = ProductInCartEntity(
                          product: carts[index].product,
                          image: carts[index].image,
                          quantity: carts[index].quantity - 1,
                        );
                      }
                    });
                  },
                ),
                Text(quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      carts[index] = ProductInCartEntity(
                        product: carts[index].product,
                        image: carts[index].image,
                        quantity: carts[index].quantity + 1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
