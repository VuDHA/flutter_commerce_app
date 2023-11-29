import 'package:get/get.dart';
import 'package:my_grocery/model/category.dart';
import 'package:my_grocery/service/local_service/local_category_service.dart';
import 'package:my_grocery/service/remote_service/remote_category_service.dart';

// Controller class for managing categories
class CategoryController extends GetxController {
  // Singleton instance of CategoryController
  static CategoryController instance = Get.find();

  // RxList for storing and observing the list of categories
  RxList<Category> categoryList = List<Category>.empty(growable: true).obs;

  // Local category service instance
  final LocalCategoryService _localCategoryService = LocalCategoryService();

  // RxBool for observing the loading state of categories
  RxBool isCategoryLoading = false.obs;

  // Initialization method called when the controller is first created
  @override
  void onInit() async {
    // Initialize the local category service
    await _localCategoryService.init();

    // Fetch categories
    getCategories();

    super.onInit();
  }

  // Method for fetching categories from both local and remote sources
  void getCategories() async {
    try {
      // Set the loading state to true
      isCategoryLoading(true);

      // Check if there are categories in local storage
      if (_localCategoryService.getCategories().isNotEmpty) {
        // Assign local categories to the observed list
        categoryList.assignAll(_localCategoryService.getCategories());
      }

      // Fetch categories from the remote service
      var result = await RemoteCategoryService().get();

      // If remote categories are available
      if (result != null) {
        // Assign remote categories to the observed list
        categoryList.assignAll(categoryListFromJson(result.body));

        // Update local storage with the fetched categories
        _localCategoryService.assignAllCategories(
            categories: categoryListFromJson(result.body));
      }
    } finally {
      // Set the loading state to false after fetching is complete
      isCategoryLoading(false);
    }
  }
}
