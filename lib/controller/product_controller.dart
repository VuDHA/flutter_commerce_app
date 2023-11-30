import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_grocery/model/product.dart';
import 'package:my_grocery/service/remote_service/remote_product.dart';

// Controller class for managing the state and logic related to products
class ProductController extends GetxController {
  // Singleton instance of ProductController
  static ProductController instance = Get.find();

  // TextEditingController for the search input
  TextEditingController searchTextEditController = TextEditingController();

  // RxString for observing the search value
  RxString searchVal = ''.obs;

  // RxList for storing and observing the list of products
  RxList<Product> productList = List<Product>.empty(growable: true).obs;

  // RxBool for observing the loading state of products
  RxBool isProductLoading = false.obs;

  // Initialization method called when the controller is first created
  @override
  void onInit() {
    // Fetch all products when the controller is initialized
    getProducts();
    super.onInit();
  }

  // Method for fetching all products
  void getProducts() async {
    try {
      // Set the loading state for products to true
      isProductLoading(true);

      // Fetch all products from the remote service
      var result = await RemoteProductService().get();

      // If products are available from the remote service
      if (result != null) {
        // Assign the fetched products to the observed list
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      // Set the loading state for products to false after fetching is complete
      isProductLoading(false);
    }
  }

  // Method for fetching products by name using a keyword
  void getProductByName({required String keyword}) async {
    try {
      // Set the loading state for products to true
      isProductLoading(true);

      // Fetch products by name from the remote service using a keyword
      var result = await RemoteProductService().getByName(keyword: keyword);

      // If products are available from the remote service
      if (result != null) {
        // Assign the fetched products to the observed list
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      // Set the loading state for products to false after fetching is complete
      isProductLoading(false);

      // Print the length of the product list for debugging purposes
      print(productList.length);
    }
  }

  // Method for fetching products by category using a category ID
  void getProductByCategory({required int id}) async {
    try {
      // Set the loading state for products to true
      isProductLoading(true);

      // Fetch products by category from the remote service using a category ID
      var result = await RemoteProductService().getByCategory(id: id);

      // If products are available from the remote service
      if (result != null) {
        // Assign the fetched products to the observed list
        productList.assignAll(productListFromJson(result.body));
      }
    } finally {
      // Set the loading state for products to false after fetching is complete
      isProductLoading(false);

      // Print the length of the product list for debugging purposes
      print(productList.length);
    }
  }
}
