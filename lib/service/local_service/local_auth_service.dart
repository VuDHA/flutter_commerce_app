import 'package:hive/hive.dart';

import '../../model/user.dart';

// A service class for managing local storage of authentication-related data using Hive
class LocalAuthService {
  // Hive boxes to store token and user objects
  late Box<String> _tokenBox;
  late Box<User> _userBox;
  late Box<String> _roleBox;

  // Initialization method to open the Hive boxes for token and user
  Future<void> init() async {
    _tokenBox = await Hive.openBox<String>('token');
    _userBox = await Hive.openBox<User>('user');
    _roleBox = await Hive.openBox<String>('role');
  }

  // Method to add a token to the token box
  Future<void> addToken({required String token}) async {
    await _tokenBox.put('token', token);
  }

  // Method to add a user to the user box
  Future<void> addUser({required User user}) async {
    await _userBox.put('user', user);
  }

  // Method to add role to the user box
  Future<void> addRole({required String role}) async {
    await _roleBox.put('role', role);
  }

  // Method to clear both token and user boxes
  Future<void> clear() async {
    await _tokenBox.clear();
    await _userBox.clear();
    await _roleBox.clear();
  }

  // Method to retrieve the stored token from the token box
  String? getToken() => _tokenBox.get('token');

  // Method to retrieve the stored user from the user box
  User? getUser() => _userBox.get('user');

  String? getRole() => _roleBox.get('role');
}
