import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

// A service class for handling remote API calls related to popular categories
class RemotePopularCategoryService {
  // HTTP client for making network requests
  var client = http.Client();

  // Remote API endpoint for popular categories
  var remoteUrl = '$baseUrl/api/popular-categories';

  // Method for retrieving information about popular categories from the remote API
  Future<dynamic> get() async {
    // GET request to the popular categories endpoint with image data population
    // and pagination parameters to limit the result to 5 items starting from index 0
    var response = await client.get(
      Uri.parse(
        '$remoteUrl?populate=category,category.image&pagination[start]=0&pagination[limit]=5',
      ),
    );

    // Return the API response
    return response;
  }
}
