import 'package:flutter/material.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // Dummy data for products in the cart
  final List<Map<String, dynamic>> cartItems = [
    {
      'id': '1',
      'name': 'Chicken Breast',
      'price': 5.99,
      'imageUrl': 'https://via.placeholder.com/150', // Replace with actual URL
      'quantity': 1,
    },
    {
      'id': '2',
      'name': 'Beef Steak',
      'price': 15.99,
      'imageUrl': 'https://via.placeholder.com/150', // Replace with actual URL
      'quantity': 2,
    },
    {
      'id': '3',
      'name': 'Pork Chops',
      'price': 12.99,
      'imageUrl': 'https://via.placeholder.com/150', // Replace with actual URL
      'quantity': 1,
    },
  ];

  // Calculate the total price of the items in the cart
  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + item['price'] * item['quantity'],
    );
  }

  // Update the quantity of an item
  void updateQuantity(String id, int quantity) {
    setState(() {
      for (var item in cartItems) {
        if (item['id'] == id) {
          item['quantity'] = quantity;
          break;
        }
      }
    });
  }

  // Remove an item from the cart
  void removeItem(String id) {
    setState(() {
      cartItems.removeWhere((item) => item['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(item['imageUrl'] as String),
                      title: Text(item['name'] as String),
                      subtitle: Text('Price: \$${item['price']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (item['quantity'] > 1) {
                                updateQuantity(item['id'] as String, item['quantity'] - 1);
                              } else {
                                removeItem(item['id'] as String);
                              }
                            },
                          ),
                          Text(item['quantity'].toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              updateQuantity(item['id'] as String, item['quantity'] + 1);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement checkout functionality
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
    );
  }
}

