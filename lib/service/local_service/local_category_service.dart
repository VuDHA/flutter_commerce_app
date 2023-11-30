import 'package:hive/hive.dart';

import '../../model/category.dart';

// A service class for managing local storage of category-related data using Hive
class LocalCategoryService {
  // Hive boxes to store popular and regular categories
  late Box<Category> _popularCategoryBox;
  late Box<Category> _categoryBox;

  // Initialization method to open the Hive boxes for popular and regular categories
  Future<void> init() async {
    _popularCategoryBox = await Hive.openBox<Category>('PopularCategories');
    _categoryBox = await Hive.openBox<Category>('categories');
  }

  // Method to replace all popular categories in the popular category box
  Future<void> assignAllPopularCategories({required List<Category> popularCategories}) async {
    await _popularCategoryBox.clear();
    await _popularCategoryBox.addAll(popularCategories);
  }

  // Method to replace all categories in the regular category box
  Future<void> assignAllCategories({required List<Category> categories}) async {
    await _categoryBox.clear();
    await _categoryBox.addAll(categories);
  }

  // Method to retrieve all popular categories from the popular category box
  List<Category> getPopularCategories() => _popularCategoryBox.values.toList();

  // Method to retrieve all categories from the regular category box
  List<Category> getCategories() => _categoryBox.values.toList();
}
