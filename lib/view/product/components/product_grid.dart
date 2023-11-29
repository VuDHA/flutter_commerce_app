import 'package:flutter/material.dart';
import 'package:my_grocery/view/product/components/product_card.dart';

import '../../../model/product.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Grid configuration
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // Maximum cross-axis extent of each item
        childAspectRatio: 2 / 3, // Aspect ratio of each item (width / height)
        crossAxisSpacing: 10, // Spacing between items in the cross axis
        mainAxisSpacing: 10, // Spacing between items in the main axis
      ),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }
}
