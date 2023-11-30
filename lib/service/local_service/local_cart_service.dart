import 'package:hive/hive.dart';
import '../../model/cart_item.dart';

class LocalCartService {
  late Box<CartItem> _cartBox;

  // Initialization method to open the Hive box for the cart
  Future<void> init() async {
    _cartBox = await Hive.openBox<CartItem>('cart');
  }

  // Method to check if the cart is empty
  bool isCartEmpty() => _cartBox.isEmpty;

  // Method to get all cart items
  List<CartItem> getCartItems() => _cartBox.values.toList();

  // Method to add a cart item to the cart
  Future<void> addToCart(CartItem cartItem) async {
    await _cartBox.add(cartItem);
  }

  // Method to remove a cart item from the cart
  Future<void> removeFromCart(CartItem cartItem) async {
    await cartItem.delete(); // Delete from Hive
  }

  // Method to clear all cart items
  Future<void> clearCart() async {
    await _cartBox.clear();
  }
}
