import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Loading card widget for popular category with shimmer effect
class PopularCategoryLoadingCard extends StatelessWidget {
  const PopularCategoryLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Padding around the loading card
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
      // Material widget for elevation and shadow
      child: Material(
        elevation: 8,
        shadowColor: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        // Shimmer effect for a loading container with specified dimensions
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: Container(
            width: 270,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
