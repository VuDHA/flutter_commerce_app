import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_grocery/const.dart';

class RemoteProductCrudService {
  final http.Client client = http.Client();
  final String remoteUrl = '$baseUrl/api/products';

  // Method for creating a new product
  Future<dynamic> create(Map<String, dynamic> productData) async {
    var response = await client.post(
      Uri.parse('$remoteUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(productData),
    );

    return response;
  }

  // Method for retrieving information about all products
  Future<dynamic> getAll() async {
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=images,tags'),
    );

    return response;
  }

  // Method for retrieving information about a specific product by ID
  Future<dynamic> getById({required int id}) async {
    var response = await client.get(
      Uri.parse('$remoteUrl/$id'),
    );

    return response;
  }

  // Method for updating an existing product by ID
  Future<dynamic> update({required int id, required Map<String, dynamic> updatedData}) async {
    var response = await client.put(
      Uri.parse('$remoteUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    return response;
  }

  // Method for deleting a product by ID
  Future<dynamic> delete({required int id}) async {
    var response = await client.delete(
      Uri.parse('$remoteUrl/$id'),
    );

    return response;
  }
}
