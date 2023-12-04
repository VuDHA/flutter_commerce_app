import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:my_grocery/const.dart';
import 'package:my_grocery/controller/controllers.dart';
import '../../controller/auth_controller.dart';
import '../local_service/local_auth_service.dart';

class RemoteProductService {
  var client = http.Client();
  late LocalAuthService localAuthService; // Late initialization

  // Remote API endpoint for products
  var remoteUrl = '$baseUrl/api/products';

  RemoteProductService() {
    // Check if AuthController is registered with Get
    if (Get.isRegistered<AuthController>()) {
      // Access the localAuthService from the registered instance
      localAuthService = authController.localAuthService;
    }
  }

  // Method for retrieving information about all products from the remote API
  Future<dynamic> get() async {
    await _checkAuthController();
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=images,tags'),
    );
    return response;
  }

  // Method for retrieving information about products by name from the remote API
  Future<dynamic> getByName({required String keyword}) async {
    await _checkAuthController();
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=images,tags&filters[name][\$contains]=$keyword'),
    );
    return response;
  }

  // Method for retrieving information about products by category ID from the remote API
  Future<dynamic> getByCategory({required int id}) async {
    await _checkAuthController();
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=images,tags&filters[category][id]=$id'),
    );
    return response;
  }

  Future<dynamic> create(Map<String, dynamic> productData) async {
    await _checkAuthController();
    var requestData = {"data": productData};
    var token = localAuthService.getToken();
    var response = await client.post(
      Uri.parse(remoteUrl),
      headers: {'Content-Type': 'application/json', "Authorization": "Bearer $token"},
      body: jsonEncode(requestData),
    );
    return response;
  }

  // Method for retrieving information about all products
  Future<dynamic> getAll() async {
    await _checkAuthController();
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=images,tags'),
    );
    return response;
  }

  // Method for retrieving information about a specific product by ID
  Future<dynamic> getById({required int id}) async {
    await _checkAuthController();
    var response = await client.get(
      Uri.parse('$remoteUrl/$id'),
    );
    return response;
  }

  // Method for updating an existing product by ID
  Future<dynamic> update({required int id, required Map<String, dynamic> updatedData}) async {
    await _checkAuthController();
    var requestData = {"data": updatedData};
    var token = localAuthService.getToken();
    var response = await client.put(
      Uri.parse('$remoteUrl/$id'),
      headers: {'Content-Type': 'application/json', "Authorization": "Bearer $token"},
      body: jsonEncode(requestData),
    );
    return response;
  }

  // Method for deleting a product by ID
  Future<dynamic> delete({required int id}) async {
    await _checkAuthController();
    var token = localAuthService.getToken();
    var response = await client.delete(
      Uri.parse('$remoteUrl/$id'),
      headers: {'Content-Type': 'application/json', "Authorization": "Bearer $token"},
    );
    return response;
  }

  // Check AuthController before accessing localAuthService
  Future<void> _checkAuthController() async {
    if (!Get.isRegistered<AuthController>()) {}
  }
}
