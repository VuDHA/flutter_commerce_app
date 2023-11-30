import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Obx(
        () {
          var cartBox = cartController.cartItems;

          return cartBox.isEmpty
              ? const Center(
                  child: Text('Your cart is empty!'),
                )
              : ListView.builder(
                  itemCount: cartBox.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartBox[index];

                    return ListTile(
                      title: Text(cartItem.product.name),
                      subtitle: Text('Price: \$${cartItem.product.totalPrice * cartItem.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartController.updateQuantity(cartItem.id, cartItem.quantity - 1);
                            },
                          ),
                          Text('${cartItem.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cartController.updateQuantity(cartItem.id, cartItem.quantity + 1);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartController.removeFromCart(cartItem.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
          ),
          onPressed: () {
            // When the card is tapped, navigate to the ProductDetailsScreen
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              'Add to Cart',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
