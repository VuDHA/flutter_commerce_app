import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/component/main_header.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/view/product/components/product_grid.dart';
import 'package:my_grocery/view/product/components/product_loading_grid.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          print('Refresh triggered');
          productController.getProducts();
        },
        child: Column(
          children: [
            // Display the main header at the top
            const MainHeader(),

            Expanded(
              child: Obx(() {
                // Check if products are still loading
                if (productController.isProductLoading.value) {
                  // Display loading grid while products are loading
                  return const ProductLoadingGrid();
                } else {
                  // Check if product list is not empty
                  if (productController.productList.isNotEmpty) {
                    // Display grid of products
                    return ProductGrid(products: productController.productList);
                  } else {
                    // Display message and image when no products are found
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/product_not_found.png'),
                        const SizedBox(height: 10),
                        const Text('Products Not Found!')
                      ],
                    );
                  }
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
