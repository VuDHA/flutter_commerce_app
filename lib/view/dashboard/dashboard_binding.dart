import 'package:get/get.dart';
import 'package:my_grocery/controller/auth_controller.dart';
import 'package:my_grocery/controller/category_controller.dart';
import 'package:my_grocery/controller/dashboard_controller.dart';
import 'package:my_grocery/controller/home_controller.dart';
import 'package:my_grocery/controller/product_controller.dart';
import 'package:my_grocery/controller/profile_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize and inject controllers into the GetX dependency injection system
    Get.put(DashboardController()); // Controller for managing dashboard-related logic
    Get.put(HomeController()); // Controller for managing home-related logic
    Get.put(ProductController()); // Controller for managing product-related logic
    Get.put(CategoryController()); // Controller for managing category-related logic
    Get.put(AuthController()); // Controller for managing authentication-related logic
    Get.put(ProfileController()); // Controller for managing user profile-related logic
  }
}
