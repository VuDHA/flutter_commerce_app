import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../const.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the product creation screen
                  Get.toNamed('/createProduct');
                },
                child: Text('Create Product'),
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  var productList = crudProductController.productList;

                  if (productList.isEmpty) {
                    return Center(
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
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigate to the product edit screen
                                Get.toNamed('/editProduct/${product.id}');
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
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
          ],
        ),
      ),
    );
  }
}
