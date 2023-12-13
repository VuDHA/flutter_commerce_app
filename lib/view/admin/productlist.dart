import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:my_grocery/view/admin/create_product.dart';
import 'package:my_grocery/view/admin/update_product.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../const.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key}) : super(key: key);

  File? _selectedImage; // Variable to store the selected image file

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the product creation screen
                      Get.to(() => const CreateProductScreen());
                    },
                    child: const Text('Create Product'),
                  ),
                  SizedBox(width: 16), // Add some space between buttons

                  ElevatedButton(
                    onPressed: () {
                      // Call a method to handle image upload
                      _pickImage();
                    },
                    child: const Text('Upload Image'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // Manually trigger the update of the UI
                  productController.getProducts();
                },
                child: Obx(
                  () {
                    var productList = productController.productList;

                    if (productList.isEmpty) {
                      return const Center(
                        child: Text('No products available.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        var product = productList[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('Total Price: \$${product.totalPrice.toStringAsFixed(2)}'),
                          leading: CachedNetworkImage(
                            imageUrl: product.images.isNotEmpty ? baseUrl + product.images.first : '',
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // Navigate to the product edit screen
                                  Get.to(() => UpdateProductScreen(product: product));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  // Call a method to delete the product
                                  crudProductController.deleteProduct(product.id);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle image upload
  void _pickImage() async {
    final pickedImage = await ImagePicker().pickMedia();

    if (pickedImage != null) {
      // Set the selected image file
      _selectedImage = File(pickedImage.path);
      authController.upload(_selectedImage);
      // For example, you can upload the image to a server or display it somewhere.
    }
  }
}
