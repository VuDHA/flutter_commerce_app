import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

// A service class for handling remote banner-related API calls
class RemoteBannerService {
  // HTTP client for making network requests
  var client = http.Client();

  // Remote API endpoint for banners
  var remoteUrl = '$baseUrl/api/banners';

  // Method for retrieving banner information from the remote API
  Future<dynamic> get() async {
    // GET request to the banners endpoint with image data population
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=image'),
    );

    // Return the API response
    return response;
  }
}
