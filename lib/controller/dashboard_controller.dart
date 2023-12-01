import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController instance = Get.find();

  var tabIndex = 0;

  void updateIndex(int index) {
    // Check if the new index is different from the current index
    if (tabIndex != index) {
      // Set the new tab index
      tabIndex = index;
    } else {
      // If the new index is the same as the current index, reset to 0
      tabIndex = 0;
    }

    // Trigger a state update to inform observers about the change
    update();
  }
}
