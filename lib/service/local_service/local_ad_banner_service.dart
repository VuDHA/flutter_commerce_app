import 'package:hive/hive.dart';
import 'package:my_grocery/model/ad_banner.dart';

// A service class for managing local storage of AdBanner objects using Hive
class LocalAdBannerService {
  // Hive box to store AdBanner objects
  late Box<AdBanner> _adBannerBox;

  // Initialization method to open the Hive box for AdBanners
  Future<void> init() async {
    _adBannerBox = await Hive.openBox<AdBanner>('AdBanners');
  }

  // Method to replace all AdBanners in the box with a new list
  Future<void> assignAllAdBanners({required List<AdBanner> adBanners}) async {
    // Clear the existing AdBanners in the box
    await _adBannerBox.clear();
    // Add all AdBanners from the new list to the box
    await _adBannerBox.addAll(adBanners);
  }

  // Method to retrieve a list of AdBanners from the box
  List<AdBanner> getAdBanners() => _adBannerBox.values.toList();
}
