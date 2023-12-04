import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add input fields for product details
            TextField(
              controller: crudProductController.nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: crudProductController.descriptionController,
              decoration: const InputDecoration(labelText: 'Product Description'),
            ),
            // Button to create the product
            ElevatedButton(
              onPressed: () {
                // Call the method to create a product
                crudProductController.createProduct();
                // Navigate back to the admin screen after product creation
                Get.back();
              },
              child: const Text('Create Product'),
            ),
          ],
        ),
      ),
    );
  }
}
