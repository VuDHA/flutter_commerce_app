import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/service/local_service/local_auth_service.dart';
import 'package:my_grocery/service/remote_service/remote_auth_service.dart';
import 'package:my_grocery/view/dashboard/dashboard_admin_screen.dart';

import '../model/user.dart';
import '../view/admin/productlist.dart';

// Controller class for handling authentication-related functionality
class AuthController extends GetxController {
  // Singleton instance of AuthController
  static AuthController instance = Get.find();

  // Rxn (reactive) variable for holding the user's authentication status
  Rxn<User> user = Rxn<User>();

  // Local authentication service instance
  final LocalAuthService _localAuthService = LocalAuthService();

  // Initialization method called when the controller is first created
  @override
  void onInit() async {
    // Initialize the local authentication service
    await _localAuthService.init();
    super.onInit();
  }

  // Method for user registration
  void signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      // Display loading indicator
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );

      // Attempt to register the user remotely
      var result = await RemoteAuthService().signUp(
        email: email,
        password: password,
      );

      // If registration is successful
      if (result.statusCode == 200) {
        // Extract the JWT token from the response
        String token = json.decode(result.body)['jwt'];

        // Create the user's profile remotely
        var userResult = await RemoteAuthService().createProfile(fullName: fullName, token: token);

        // If profile creation is successful
        if (userResult.statusCode == 200) {
          // Set the user value using the decoded user data
          user.value = userFromJson(userResult.body);

          // Save the token and user locally
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);

          // Show success message and dismiss loading indicator
          EasyLoading.showSuccess("Welcome to MyGrocery!");
          Navigator.of(Get.overlayContext!).pop();
        } else {
          EasyLoading.showError('Something wrong. Try again!');
        }
      } else {
        EasyLoading.showError('Something wrong. Try again!');
      }
    } catch (e) {
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      // Dismiss loading indicator
      EasyLoading.dismiss();
    }
  }

  // Method for user sign-in
  void signIn({required String email, required String password}) async {
    try {
      // Display loading indicator
      EasyLoading.show(
        status: 'Loading...',
        dismissOnTap: false,
      );

      // Attempt to sign in the user remotely
      var result = await RemoteAuthService().signIn(
        email: email,
        password: password,
      );

      // If sign-in is successful
      if (result.statusCode == 200) {
        // Extract the JWT token from the response
        String token = json.decode(result.body)['jwt'];
        String role = json.decode(result.body)["user"]["perm"];

        // Retrieve the user's profile remotely
        var userResult = await RemoteAuthService().getProfile(token: token);

        // If profile retrieval is successful
        if (userResult.statusCode == 200) {
          // Set the user value using the decoded user data
          user.value = userFromJson(userResult.body);

          // Save the token and user locally
          await _localAuthService.addToken(token: token);
          await _localAuthService.addUser(user: user.value!);

          // Show success message and dismiss loading indicator
          EasyLoading.showSuccess("Welcome to MyGrocery!");
          if (role == "User") {
            Navigator.of(Get.overlayContext!).pop();
          } else {
            dashboardController.updateIndex(0);
            // Switch directly to the admin screen using Get
            Get.off(() => DashboardAdminScreen());
          }
        } else {
          EasyLoading.showError('Something wrong. Try again!');
        }
      } else {
        EasyLoading.showError('Username/password wrong');
      }
    } catch (e) {
      // Print error details to debug output
      debugPrint(e.toString());

      // Show error message and dismiss loading indicator
      EasyLoading.showError('Something wrong. Try again!');
    } finally {
      // Dismiss loading indicator
      EasyLoading.dismiss();
    }
  }

  // Method for user sign-out
  void signOut() async {
    // Reset the user value and clear local storage
    user.value = null;
    await _localAuthService.clear();
  }
}
