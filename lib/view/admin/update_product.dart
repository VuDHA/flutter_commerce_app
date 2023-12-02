import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';

import '../../model/product.dart';

class UpdateProductScreen extends StatelessWidget {
  final Product product;

  // Constructor to receive the existing product details
  UpdateProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    // Set the existing product details to the controller for pre-filling
    crudProductController.nameController.text = product.name;
    crudProductController.descriptionController.text = product.description;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add input fields for updated product details
            TextField(
              controller: crudProductController.nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: crudProductController.descriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            // Button to update the product
            ElevatedButton(
              onPressed: () {
                // Call the method to update the product
                crudProductController.updateProduct(product.id);

                // Navigate back to the admin screen after product update
                Get.back();
              },
              child: Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
