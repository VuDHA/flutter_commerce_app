import 'package:get/get.dart';
import 'package:my_grocery/model/cart_item.dart';

import '../service/local_service/local_cart_service.dart';

class CartController extends GetxController {
  // Singleton instance of CartController
  static CartController instance = Get.find();

  // RxList for storing and observing the list of cart items
  RxList<CartItem> cartItems = <CartItem>[].obs;

  // Local category service instance
  final LocalCartService _localCartService = LocalCartService();

  // RxBool for observing the loading state of cart items (not currently used)
  RxBool isCartLoading = false.obs;

  /// Method to add a product to the cart.
  /// If the product is already in the cart, it updates the quantity;
  /// otherwise, it adds a new cart item to the cartItems list.
  void addToCart(CartItem cartItem) {
    // Check if the cart item is already in the cart
    bool isInCart = cartItems.any((item) => cartItem.product.id == item.product.id);

    if (isInCart) {
      // If the product is already in the cart, update the quantity
      updateQuantitywhenAdd(cartItem.product.id, cartItem.quantity);
    } else {
      // If the product is not in the cart, add it to the cart items list
      cartItems.add(cartItem);
    }
  }

  /// Method to update the quantity of a cart item in the cart.
  /// It finds the cart item with the specified ID and updates its quantity.
  void updateQuantity(int cartId, int newQuantity) {
    // Find the cart item with the specified ID
    CartItem? existingCartItem = cartItems.firstWhereOrNull((item) => item.id == cartId);

    if (existingCartItem != null) {
      if (newQuantity == 0) {
        existingCartItem.quantity = 1;
        cartItems.refresh();
      } else {
        // If the cart item is found, update its quantity
        existingCartItem.quantity = newQuantity;
        cartItems.refresh();
      }
    }
  }

  /// Method to update the quantity of a cart item in the cart.
  /// It finds the cart item with the specified ID and updates its quantity.
  void updateQuantitywhenAdd(int cartId, int newQuantity) {
    // Find the cart item with the specified ID
    CartItem? existingCartItem = cartItems.firstWhereOrNull((item) => item.id == cartId);

    if (existingCartItem != null) {
      if (newQuantity == 0) {
        existingCartItem.quantity = 1;
        cartItems.refresh();
      } else {
        // If the cart item is found, update its quantity
        existingCartItem.quantity += newQuantity;
        cartItems.refresh();
      }
    }
  }

  /// Method to remove a cart item from the cart based on its ID.
  void removeFromCart(int cartId) {
    // Remove the cart item with the specified ID
    cartItems.removeWhere((item) => item.id == cartId);
  }

  /// Method to clear all items from the cart.
  void clearCart() {
    cartItems.clear();
  }
}
