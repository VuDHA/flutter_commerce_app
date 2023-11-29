import 'package:flutter/material.dart';

class InputTextButton extends StatelessWidget {
  // Properties required for the button
  final String title; // Text to be displayed on the button
  final Function onClick; // Callback function to be executed on button click

  // Constructor to initialize the properties
  const InputTextButton({Key? key, required this.title, required this.onClick})
      : super(key: key);

  // Build method to create the widget tree
  @override
  Widget build(BuildContext context) {
    // Return a TextButton widget with specific styling
    return TextButton(
      style: TextButton.styleFrom(
        // Set text and background colors based on the theme
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        // Set minimum button size and padding
        minimumSize: const Size(double.maxFinite, 50),
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        // Set button shape with rounded corners
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
      ),
      // Handle button press
      onPressed: () {
        // Remove focus from any active input fields
        FocusScope.of(context).requestFocus(FocusNode());
        // Execute the provided onClick callback
        onClick();
      },
      // Display the button text with specific styling
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
