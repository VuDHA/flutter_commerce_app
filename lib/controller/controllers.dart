import 'package:my_grocery/controller/auth_controller.dart';
import 'package:my_grocery/controller/cart_controller.dart';
import 'package:my_grocery/controller/category_controller.dart';
import 'package:my_grocery/controller/home_controller.dart';
import 'package:my_grocery/controller/product_controller.dart';
import 'package:my_grocery/controller/profile_controller.dart';

import 'dashboard_controller.dart';

// Manages the state and logic related to the home screen of the application.
HomeController homeController = HomeController.instance;

// Handles product-related functionality, including fetching, displaying, and managing products.
ProductController productController = ProductController.instance;

CartController cartController = CartController.instance;

// Manages the state and logic related to the dashboard or main screen of the application,
// coordinating various components or sections.
DashboardController dashboardController = DashboardController.instance;

// Handles the state and logic related to product categories, including fetching and managing categories.
CategoryController categoryController = CategoryController.instance;

// Manages user authentication-related functionality, including sign-up, sign-in, and sign-out.
AuthController authController = AuthController.instance;

// Handles the state and logic related to user profiles, including displaying user information
// and managing profile settings.
ProfileController profileController = ProfileController.instance;
