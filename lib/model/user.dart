import 'dart:convert'; // For handling JSON decoding

import 'package:hive/hive.dart'; // Hive for local storage

// Part file for Hive code generation
part 'user.g.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

// User class representing a user in the application
@HiveType(typeId: 4) // HiveType annotation for Hive integration
class User {
  @HiveField(0) // HiveField annotation for Hive integration
  String id; // Unique identifier for the user
  @HiveField(1) // HiveField annotation for Hive integration
  String fullName; // Full name of the user
  @HiveField(2) // HiveField annotation for Hive integration
  String email; // Email address of the user
  @HiveField(3) // HiveField annotation for Hive integration
  String? image; // Optional profile image URL
  @HiveField(4) // HiveField annotation for Hive integration
  DateTime? birthDay; // Optional birthday of the user

  // Constructor to create a User instance
  User({
    required this.id,
    required this.fullName,
    required this.email,
    this.image,
    this.birthDay,
  });

  // Factory method to create a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'].toString(),
        fullName: data['fullName'],
        email: data['email'],
        // Check for the existence of 'image' and 'age' attributes in the JSON data
        image: data['image'] == null ? null : data['image']['url'],
        birthDay: data['age'] == null ? null : DateTime.parse(data['age']),
      );
}
