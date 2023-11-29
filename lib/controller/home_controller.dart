import 'package:get/get.dart';
import 'package:my_grocery/model/ad_banner.dart';
import 'package:my_grocery/model/category.dart';
import 'package:my_grocery/model/product.dart';
import 'package:my_grocery/service/local_service/local_ad_banner_service.dart';
import 'package:my_grocery/service/local_service/local_category_service.dart';
import 'package:my_grocery/service/local_service/local_product_service.dart';
import 'package:my_grocery/service/remote_service/remote_banner_service.dart';
import 'package:my_grocery/service/remote_service/remote_popular_category_service.dart';
import 'package:my_grocery/service/remote_service/remote_popular_product_service.dart';

// Controller class for managing the state and logic of the home screen
class HomeController extends GetxController {
  // Singleton instance of HomeController
  static HomeController instance = Get.find();

  // RxList for storing and observing the list of ad banners
  RxList<AdBanner> bannerList = List<AdBanner>.empty(growable: true).obs;

  // RxList for storing and observing the list of popular categories
  RxList<Category> popularCategoryList =
      List<Category>.empty(growable: true).obs;

  // RxList for storing and observing the list of popular products
  RxList<Product> popularProductList = List<Product>.empty(growable: true).obs;

  // RxBool for observing the loading state of ad banners
  RxBool isBannerLoading = false.obs;

  // RxBool for observing the loading state of popular categories
  RxBool isPopularCategoryLoading = false.obs;

  // RxBool for observing the loading state of popular products
  RxBool isPopularProductLoading = false.obs;

  // Local service instances for managing local data
  final LocalAdBannerService _localAdBannerService = LocalAdBannerService();
  final LocalCategoryService _localCategoryService = LocalCategoryService();
  final LocalProductService _localProductService = LocalProductService();

  // Initialization method called when the controller is first created
  @override
  void onInit() async {
    // Initialize local services
    await _localAdBannerService.init();
    await _localCategoryService.init();
    await _localProductService.init();

    // Fetch ad banners, popular categories, and popular products
    getAdBanners();
    getPopularCategories();
    getPopularProducts();

    super.onInit();
  }

  // Method for fetching ad banners from both local and remote sources
  void getAdBanners() async {
    try {
      // Set the loading state for ad banners to true
      isBannerLoading(true);

      // Check if there are ad banners in local storage
      if (_localAdBannerService.getAdBanners().isNotEmpty) {
        // Assign local ad banners to the observed list
        bannerList.assignAll(_localAdBannerService.getAdBanners());
      }

      // Fetch ad banners from the remote service
      var result = await RemoteBannerService().get();

      // If remote ad banners are available
      if (result != null) {
        // Assign remote ad banners to the observed list
        bannerList.assignAll(adBannerListFromJson(result.body));

        // Update local storage with the fetched ad banners
        _localAdBannerService.assignAllAdBanners(
            adBanners: adBannerListFromJson(result.body));
      }
    } finally {
      // Set the loading state for ad banners to false after fetching is complete
      isBannerLoading(false);
    }
  }

  // Method for fetching popular categories from both local and remote sources
  void getPopularCategories() async {
    try {
      // Set the loading state for popular categories to true
      isPopularCategoryLoading(true);

      // Check if there are popular categories in local storage
      if (_localCategoryService.getPopularCategories().isNotEmpty) {
        // Assign local popular categories to the observed list
        popularCategoryList
            .assignAll(_localCategoryService.getPopularCategories());
      }

      // Fetch popular categories from the remote service
      var result = await RemotePopularCategoryService().get();

      // If remote popular categories are available
      if (result != null) {
        // Assign remote popular categories to the observed list
        popularCategoryList.assignAll(popularCategoryListFromJson(result.body));

        // Update local storage with the fetched popular categories
        _localCategoryService.assignAllPopularCategories(
            popularCategories: popularCategoryListFromJson(result.body));
      }
    } finally {
      // Set the loading state for popular categories to false after fetching is complete
      isPopularCategoryLoading(false);
    }
  }

  // Method for fetching popular products from both local and remote sources
  void getPopularProducts() async {
    try {
      // Set the loading state for popular products to true
      isPopularProductLoading(true);

      // Check if there are popular products in local storage
      if (_localProductService.getPopularProducts().isNotEmpty) {
        // Assign local popular products to the observed list
        popularProductList.assignAll(_localProductService.getPopularProducts());
      }

      // Fetch popular products from the remote service
      var result = await RemotePopularProductService().get();

      // If remote popular products are available
      if (result != null) {
        // Assign remote popular products to the observed list
        popularProductList.assignAll(popularProductListFromJson(result.body));

        // Update local storage with the fetched popular products
        _localProductService.assignAllPopularProducts(
            popularProducts: popularProductListFromJson(result.body));
      }
    } finally {
      // Set the loading state for popular products to false after fetching is complete
      isPopularProductLoading(false);
    }
  }
}
