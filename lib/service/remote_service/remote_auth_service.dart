import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const.dart';

// A service class for handling remote authentication using API calls
class RemoteAuthService {
  // HTTP client for making network requests
  var client = http.Client();

  // Method for user registration (sign-up) using the provided email and password
  Future<dynamic> signUp({
    required String email,
    required String password,
  }) async {
    // Request body with user registration data
    var body = {"username": email, "email": email, "password": password};

    // POST request to the user registration endpoint
    var response = await client.post(
      Uri.parse('$baseUrl/api/auth/local/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    // Return the API response
    return response;
  }

  // Method for creating a user profile with the provided full name and authentication token
  Future<dynamic> createProfile({
    required String fullName,
    required String token,
  }) async {
    // Request body with user profile data
    var body = {"fullName": fullName};

    // POST request to create the user profile endpoint
    var response = await client.post(
      Uri.parse('$baseUrl/api/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(body),
    );

    // Return the API response
    return response;
  }

  // Method for user sign-in using the provided email and password
  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    // Request body with user sign-in data
    var body = {"identifier": email, "password": password};

    // POST request to the user sign-in endpoint
    var response = await client.post(
      Uri.parse('$baseUrl/api/auth/local'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    // Return the API response
    return response;
  }

  // Method for retrieving user profile information using the authentication token
  Future<dynamic> getProfile({
    required String token,
  }) async {
    // GET request to retrieve user profile information endpoint
    var response = await client.get(
      Uri.parse('$baseUrl/api/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    // Return the API response
    return response;
  }
}
