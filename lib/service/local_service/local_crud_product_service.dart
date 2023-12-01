import 'package:hive/hive.dart';

import '../../model/product.dart';

class LocalProductCrudService {
  late Box<Product> _productBox;

  // Initialization method to open the Hive box for products
  Future<void> init() async {
    _productBox = await Hive.openBox<Product>('Products');
  }

  // Method for creating a new product locally
  Future<void> create(Product product) async {
    await _productBox.add(product);
  }

  // Method for retrieving information about all products locally
  List<Product> getAll() => _productBox.values.toList();

  // Method for retrieving information about a specific product by ID locally
  Product getById(int id) => _productBox.get(id)!;

  // Method for updating an existing product locally
  Future<void> update(int id, Product updatedProduct) async {
    await _productBox.put(id, updatedProduct);
  }

  // Method for deleting a product by ID locally
  Future<void> delete(int id) async {
    await _productBox.delete(id);
  }
}
