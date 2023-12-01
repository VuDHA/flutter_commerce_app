import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_grocery/controller/controllers.dart';

import '../../../component/input_outline_button.dart';

// Represents the Profile Screen in the application
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// State class for the Profile Screen
class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers for handling email and password input
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // ListView for scrollable content
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            // Display user profile information
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
                        authController.user.value?.fullName ?? "Sign in to your account",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            // Build cards for displaying user information
            buildAccountCard(title: "Full name:    ${authController.user.value?.fullName}", onClick: () {}),
            buildAccountCard(title: "Email:    ${authController.user.value?.email}", onClick: () {}),
            buildAccountCard(
                title: "Age:    ${calculateAge(authController.user.value?.birthDay ?? DateTime.now())}",
                onClick: () {}),
            buildAccountCard(
                title:
                    "BirthDay:    ${DateFormat('dd/MM').format(authController.user.value?.birthDay ?? DateTime.now())}",
                onClick: () {}),
            const SizedBox(height: 10),
            // Back button for navigating back
            InputOutlineButton(
              title: "Back",
              onClick: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0.1,
                blurRadius: 7,
              )
            ],
          ),
          // Row for card content
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Display the title of the card
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to calculate age based on birthdate
  String calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final age = now.year -
        birthDate.year -
        (now.month > birthDate.month || (now.month == birthDate.month && now.day >= birthDate.day) ? 0 : 1);

    return '$age';
  }
}
