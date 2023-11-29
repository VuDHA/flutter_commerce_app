import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

// A service class for handling remote API calls related to popular products
class RemotePopularProductService {
  // HTTP client for making network requests
  var client = http.Client();

  // Remote API endpoint for popular products
  var remoteUrl = '$baseUrl/api/popular-products';

  // Method for retrieving information about popular products from the remote API
  Future<dynamic> get() async {
    // GET request to the popular products endpoint with image data population
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=product,product.images'),
    );

    // Return the API response
    return response;
  }
}
