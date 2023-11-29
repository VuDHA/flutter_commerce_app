import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// Widget representing a loading card for popular products
class PopularProductLoadingCard extends StatelessWidget {
  const PopularProductLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Padding containing a material card with a container displaying shimmering loading effects
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
      child: Material(
        elevation: 8,
        shadowColor: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
        child: Shimmer.fromColors(
          highlightColor: Colors.white,
          baseColor: Colors.grey.shade300,
          // Container with shimmering effect representing a loading state
          child: Container(
            margin: const EdgeInsets.all(10),
            width: 120,
            child: Column(
              children: [
                // Aspect ratio container for displaying shimmering loading effect
                AspectRatio(
                  aspectRatio: 0.9,
                  child: Container(
                    color: Colors.grey,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                  ),
                ),
                const SizedBox(height: 10),
                // Container with shimmering loading effect representing product information
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Container(
                    height: 15,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
