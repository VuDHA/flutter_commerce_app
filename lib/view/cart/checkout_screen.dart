import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_grocery/view/dashboard/dashboard_screen.dart';

import '../../controller/controllers.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display user name
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                authController.user.value?.fullName ?? "Sign in your account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Display cart items
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartController.cartItems[index];
                  return ListTile(
                    title: Text(cartItem.product.name),
                    subtitle: Text('Price: \$${cartItem.product.totalPrice * cartItem.quantity}'),
                  );
                },
              ),
            ),
            // Display total price
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Price: \$${calculateTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
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
              bool isUserSignedIn = authController.user.value != null;
              if (isUserSignedIn) {
                EasyLoading.showSuccess('Check out success, please check your email for futher proccess.');
              } else {
                EasyLoading.showToast('Please sign in your account before checkout');
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'Check out',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ));
  }

  double calculateTotalPrice() {
    var totalP = 0.0;
    for (var cartItem in cartController.cartItems) {
      totalP += cartItem.product.totalPrice * cartItem.quantity;
    }
    return totalP;
  }
}
