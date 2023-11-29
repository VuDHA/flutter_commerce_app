import 'package:flutter/material.dart';

// Widget representing a section title with an option to see more
class SectionTitle extends StatelessWidget {
  final String title;

  // Constructor to initialize the title
  const SectionTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Container with padding containing a row with the section title and "See more" text
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text widget displaying the section title with a specific style
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          // Text widget for "See more" with a specified style
          const Text(
            "See more",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
