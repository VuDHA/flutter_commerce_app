import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_grocery/component/main_header.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/view/home/components/popular_category/popular_category.dart';
import 'package:my_grocery/view/home/components/popular_product/popular_product.dart';
import 'package:my_grocery/view/home/components/popular_product/popular_product_loading.dart';
import 'package:my_grocery/view/home/components/section_title.dart';

import 'components/carousel_slider/carousel_slider_view.dart';
import 'components/popular_category/popular_category_loading.dart';
import 'components/carousel_slider/carousel_loading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // SafeArea to ensure content doesn't overlap with device status bar
      child: Column(
        children: [
          const MainHeader(), // MainHeader widget for the top section

          Expanded(
            // Expanded to allow the SingleChildScrollView to take remaining space
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              // SingleChildScrollView for scrollable content
              child: Column(
                children: [
                  Obx(() {
                    // Obx widget for reactive updates based on observable state
                    if (homeController.bannerList.isNotEmpty) {
                      return CarouselSliderView(
                        bannerList: homeController.bannerList,
                      );
                    } else {
                      return const CarouselLoading();
                    }
                  }),

                  const SectionTitle(title: "Popular Category"), // SectionTitle widget

                  Obx(() {
                    if (homeController.popularCategoryList.isNotEmpty) {
                      return PopularCategory(
                        categories: homeController.popularCategoryList,
                      );
                    } else {
                      return const PopularCategoryLoading();
                    }
                  }),

                  const SectionTitle(title: "Popular Product"), // SectionTitle widget

                  Obx(() {
                    if (homeController.popularProductList.isNotEmpty) {
                      return PopularProduct(
                        popularProducts: homeController.popularProductList,
                      );
                    } else {
                      return const PopularProductLoading();
                    }
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
