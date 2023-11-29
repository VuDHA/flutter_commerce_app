// Import the GetX package for state management
import 'package:get/get.dart';

// Controller class for managing the state and logic of the dashboard or main screen of the application
class DashboardController extends GetxController {
  // Singleton instance of the DashboardController
  static DashboardController instance = Get.find();

  // Variable to store the current tab index
  var tabIndex = 0;

  // Method to update the current tab index and trigger a state update
  void updateIndex(int index) {
    // Set the new tab index
    tabIndex = index;

    // Trigger a state update to inform observers (such as UI components) about the change
    update();
  }
}
