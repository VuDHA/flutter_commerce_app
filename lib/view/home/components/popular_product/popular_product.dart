import 'package:flutter/material.dart';
import 'package:my_grocery/view/home/components/popular_product/popular_product_card.dart';

import '/../model/product.dart';

// Widget representing a list of popular products
class PopularProduct extends StatelessWidget {
  final List<Product> popularProducts;

  // Constructor requiring a list of popular products
  const PopularProduct({Key? key, required this.popularProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Container with a fixed height, containing a horizontal ListView
    return Container(
      height: 220,
      padding: const EdgeInsets.only(right: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: popularProducts.length,
        // Builder for creating instances of PopularProductCard for each product in the list
        itemBuilder: (context, index) => PopularProductCard(product: popularProducts[index]),
      ),
    );
  }
}
