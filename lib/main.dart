import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_grocery/model/ad_banner.dart';
import 'package:my_grocery/model/category.dart';
import 'package:my_grocery/model/product.dart';
import 'package:my_grocery/model/user.dart';
import 'package:my_grocery/route/app_page.dart';
import 'package:my_grocery/route/app_route.dart';
import 'package:my_grocery/theme/app_theme.dart';

import 'model/cart_item.dart';
import 'model/tag.dart';

// Entry point of the Flutter application
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await Hive.initFlutter(); // Initialize Hive for local data storage

  // Register adapters for Hive to serialize and deserialize custom objects
  Hive.registerAdapter(AdBannerAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.openBox<CartItem>('cart');

  // Configure loading settings
  configLoading();

  // Run the main application widget
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the GetMaterialApp for routing and state management
    return GetMaterialApp(
      getPages: AppPage.list, // Define app pages
      initialRoute: AppRoute.dashboard, // Set the initial route
      debugShowCheckedModeBanner: false, // Disable debug banner
      theme: AppTheme.lightTheme, // Set the app theme
      themeMode: ThemeMode.light, // Set the theme mode
      builder: EasyLoading.init(), // Initialize loading indicator
    );
  }
}

// Function to configure loading settings
void configLoading() {
  // Access the EasyLoading instance and edited its properties
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
