import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_grocery/const.dart';
import 'package:my_grocery/model/category.dart';
import 'package:shimmer/shimmer.dart';

// A widget to display a category card with its image
class PopularCategoryCard extends StatelessWidget {
  final Category category;

  // Constructor to initialize the category for this card
  const PopularCategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Padding around the card
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
      // CachedNetworkImage efficiently loads and caches images from a network URL
      child: CachedNetworkImage(
        imageUrl: baseUrl + category.image,
        imageBuilder: (context, imageProvider) => Material(
          // Material widget for elevation and shadow
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 270,
            height: 140,
            decoration: BoxDecoration(
              // Decoration for the card with background image
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                // Displaying the category name on top of the image
                category.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Placeholder with shimmer effect while image is loading
        placeholder: (context, url) => Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
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
        // Placeholder displayed if there's an issue loading the image
        errorWidget: (context, url, error) => Material(
          elevation: 8,
          shadowColor: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 270,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.error_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
