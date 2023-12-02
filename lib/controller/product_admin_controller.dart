import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_grocery/model/product.dart';
import 'package:my_grocery/service/remote_service/remote_product.dart';

class CrudProductController extends GetxController {
  // Singleton instance of CrudProductController
  static CrudProductController instance = Get.find();

  // RxBool for observing the saving state of a product
  RxBool isSavingProduct = false.obs;

  // TextEditingController for product details
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  // RxList for storing and observing the list of products
  RxList<Product> productList = List<Product>.empty(growable: true).obs;

  // Initialization method called when the controller is first created
  @override
  void onInit() {
    // Fetch all products when the controller is initialized
    getProducts();
    super.onInit();
  }

  // Method for creating a new product
  void createProduct() async {
    try {
      // Set the saving state for the product to true
      isSavingProduct(true);

      // Create a new product using the entered details
      Product newProduct = Product(
        id: productList.length + 1, // Assuming the ID is generated locally
        name: nameController.text,
        description: descriptionController.text,
        images: [], // You can add images as needed
        tags: [], // You can add tags as needed
      );

      // Save the new product to the remote service
      var result = await RemoteProductService().create(newProduct.toJson());

      // If the product is successfully created remotely
      if (result != null) {
        // Add the new product to the local list
        productList.add(newProduct);

        // Print a success message or handle it as needed
        print('Product created successfully');
      }
    } finally {
      // Set the saving state for the product to false after creation is complete
      isSavingProduct(false);
    }
  }

  void updateProduct(int productId) async {
    try {
      // Set the saving state for the product to true
      isSavingProduct(true);

      // Find the existing product in the local list
      Product existingProduct = productList.firstWhere((product) => product.id == productId);

      // Create a new product instance with the updated data
      var updatedProduct = Map<String, dynamic>.from({
        'id': existingProduct.id,
        'name': nameController.text,
        'description': descriptionController.text,
        'tags': existingProduct.tags,
      });

      Product updatedProductt = Product(
        id: existingProduct.id,
        name: nameController.text,
        description: descriptionController.text,
        images: existingProduct.images,
        tags: existingProduct.tags,
      );

      // Save the updated product to the remote service
      var result = await RemoteProductService().update(id: productId, updatedData: updatedProduct);

      // If the product is successfully updated remotely
      if (result != null) {
        // Replace the existing product in the local list with the updated product
        int index = productList.indexWhere((product) => product.id == productId);
        if (index != -1) {
          productList[index] = updatedProductt;
        }
      }
    } finally {
      // Set the saving state for the product to false after updating is complete
      isSavingProduct(false);
    }
  }

  // Method for deleting a product
  void deleteProduct(int productId) async {
    try {
      // Set the saving state for the product to true
      isSavingProduct(true);

      // Delete the product from the remote service
      var result = await RemoteProductService().delete(id: productId);

      // If the product is successfully deleted remotely
      if (result != null) {
        // Remove the product from the local list
        productList.removeWhere((product) => product.id == productId);

        // Print a success message or handle it as needed
        print('Product deleted successfully');
      }
    } finally {
      // Set the saving state for the product to false after deletion is complete
      isSavingProduct(false);
    }
  }

  // Method for fetching all products
  void getProducts() async {
    try {
      // Set the loading state for products to true
      isSavingProduct(true);

      // Fetch all products from the remote service
      var result = await RemoteProductService().getAll();

      // If products are available from the remote service
      if (result != null) {
        // Assign the fetched products to the observed list
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      // Set the loading state for products to false after fetching is complete
      isSavingProduct(false);
    }
  }
}
