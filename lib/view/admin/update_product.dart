import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';

import '../../model/product.dart';

class UpdateProductScreen extends StatelessWidget {
  final Product product;

  // Constructor to receive the existing product details
  const UpdateProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the existing product details to the controller for pre-filling
    crudProductController.getProducts();
    crudProductController.nameController.text = product.name;
    crudProductController.descriptionController.text = product.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add input fields for updated product details
            TextField(
              controller: crudProductController.nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: crudProductController.descriptionController,
              decoration: const InputDecoration(labelText: 'Product Description'),
            ),
            // Button to update the product
            ElevatedButton(
              onPressed: () {
                // Call the method to update the product
                crudProductController.updateProduct(product.id);
                productController.getProducts();

                // Navigate back to the admin screen after product update
                Get.back();
              },
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
