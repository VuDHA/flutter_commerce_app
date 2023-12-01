import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/view/account/auth/profile_info.dart';
import 'package:my_grocery/view/dashboard/dashboard_screen.dart';

import 'auth/sign_in_screen.dart';

// Represents the Account Screen in the application
class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Padding to provide spacing from the edges of the screen
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      // ListView for scrollable content
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          // Display user profile information or a sign-in prompt
          Obx(
            () => Row(
              children: [
                // User profile avatar
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 36,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/user_image.png"),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    // Display user's full name or a sign-in prompt
                    Text(
                      authController.user.value?.fullName ?? "Sign in your account",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 50),
          // Build a card for navigating to the Profile Screen
          buildAccountCard(
              title: "Profile Info",
              onClick: () {
                if (authController.user.value != null) {
                  // Navigate to the Profile Screen if the user is signed in
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                } else {
                  // Navigate to the Sign-In Screen if the user is not signed in
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                }
              }),
          // Additional account-related cards can be added here
          // buildAccountCard(title: "Notification", onClick: () {}),
          // buildAccountCard(title: "Settings", onClick: () {}),
          // buildAccountCard(title: "About Us", onClick: () {}),
          // buildAccountCard(title: "Terms of Service", onClick: () {}),
          // Build a card for signing in or out
          Obx(() => buildAccountCard(
              title: authController.user.value == null ? "Sign In" : "Sign Out",
              onClick: () {
                if (authController.user.value != null) {
                  // Sign out if the user is signed in
                  authController.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
                } else {
                  // Navigate to the Sign-In Screen if the user is not signed in
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
                }
              }))
        ],
      ),
    );
  }

  // Widget for building an account-related card
  Widget buildAccountCard({required String title, required Function() onClick}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      // GestureDetector for making the card tappable
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // Decoration for the card
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.all(Radius.circular(12)), boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0.1,
              blurRadius: 7,
            )
          ]),
          // Row for card content
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display the title of the card
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              // Arrow icon for indicating that the card is tappable
              const Icon(Icons.keyboard_arrow_right_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
