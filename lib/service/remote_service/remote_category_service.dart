import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

// A service class for handling remote category-related API calls
class RemoteCategoryService {
  // HTTP client for making network requests
  var client = http.Client();

  // Remote API endpoint for categories
  var remoteUrl = '$baseUrl/api/categories';

  // Method for retrieving category information from the remote API
  Future<dynamic> get() async {
    // GET request to the categories endpoint with image data population
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=image'),
    );

    // Return the API response
    return response;
  }
}
