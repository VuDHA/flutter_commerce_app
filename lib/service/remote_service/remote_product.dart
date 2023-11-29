import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

// A service class for handling remote API calls related to products
class RemoteProductService {
  // HTTP client for making network requests
  var client = http.Client();

  // Remote API endpoint for products
  var remoteUrl = '$baseUrl/api/products';

  // Method for retrieving information about all products from the remote API
  Future<dynamic> get() async {
    // GET request to the products endpoint with image and tag data population
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=images,tags'),
    );

    // Return the API response
    return response;
  }

  // Method for retrieving information about products by name from the remote API
  Future<dynamic> getByName({required String keyword}) async {
    // GET request to the products endpoint with image and tag data population
    // and a filter for products whose names contain the specified keyword
    var response = await client.get(
      Uri.parse(
          '$remoteUrl?populate=images,tags&filters[name][\$contains]=$keyword'),
    );

    // Return the API response
    return response;
  }

  // Method for retrieving information about products by category ID from the remote API
  Future<dynamic> getByCategory({required int id}) async {
    // GET request to the products endpoint with image and tag data population
    // and a filter for products in the specified category
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=images,tags&filters[category][id]=$id'),
    );

    // Return the API response
    return response;
  }
}
