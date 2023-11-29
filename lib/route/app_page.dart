import 'package:get/get.dart';
import 'package:my_grocery/route/app_route.dart';
import 'package:my_grocery/view/dashboard/dashboard_binding.dart';
import 'package:my_grocery/view/dashboard/dashboard_screen.dart';

// A class containing static pages for the application
class AppPage {
  // List of GetPages used for routing
  static var list = [
    GetPage(
      // Route name defined in AppRoute class
      name: AppRoute.dashboard,
      // Page widget associated with the route
      page: () => const DashboardScreen(),
      // Binding class associated with the page
      binding: DashboardBinding(),
    ),
  ];
}
