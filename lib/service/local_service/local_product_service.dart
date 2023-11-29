import 'package:hive/hive.dart';

import '../../model/product.dart';

// A service class for managing local storage of popular products using Hive
class LocalProductService {
  // Hive box to store popular products
  late Box<Product> _popularProductBox;

  // Initialization method to open the Hive box for popular products
  Future<void> init() async {
    _popularProductBox = await Hive.openBox<Product>('PopularProducts');
  }

  // Method to replace all popular products in the popular product box
  Future<void> assignAllPopularProducts(
      {required List<Product> popularProducts}) async {
    await _popularProductBox.clear();
    await _popularProductBox.addAll(popularProducts);
  }

  // Method to retrieve all popular products from the popular product box
  List<Product> getPopularProducts() => _popularProductBox.values.toList();
}
