import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/view/category/components/category_card.dart';

// Represents the Category Screen in the application
class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obx widget to reactively rebuild the UI when the category list changes
    return Obx(() {
      // Check if the category list is not empty
      if (categoryController.categoryList.isNotEmpty) {
        // Return a ListView of CategoryCard widgets for each category
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoryController.categoryList.length,
          itemBuilder: (context, index) =>
              CategoryCard(category: categoryController.categoryList[index]),
        );
      } else {
        // Return an empty container if the category list is empty
        return Container();
      }
    });
  }
}
