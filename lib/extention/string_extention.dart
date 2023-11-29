// Extension on String to add utility methods for common validations and transformations
extension ExtString on String {
  // Capitalizes the first letter of the string and converts the rest to lowercase
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  // Checks if the string is a valid email address
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  // Checks if the string is a valid name
  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  // Checks if the string is a valid password with specific requirements
  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  // Checks if the string contains at least one special character
  bool get isValidPasswordHasSpecialCharacter {
    final passwordRegExp = RegExp(r'[!@#$\><*~]');
    return passwordRegExp.hasMatch(this);
  }

  // Checks if the string contains at least one capital letter
  bool get isValidPasswordHasCapitalLetter {
    final passwordRegExp = RegExp(r'[A-Z]');
    return passwordRegExp.hasMatch(this);
  }

  // Checks if the string contains at least one lowercase letter
  bool get isValidPasswordHasLowerCaseLetter {
    final passwordRegExp = RegExp(r'[a-z]');
    return passwordRegExp.hasMatch(this);
  }

  // Checks if the string contains at least one number
  bool get isValidPasswordHasNumber {
    final passwordRegExp = RegExp(r'[0-9]');
    return passwordRegExp.hasMatch(this);
  }

  // Checks if the string is a valid phone number (starting with '+', followed by 10 digits)
  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
