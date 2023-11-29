import 'package:flutter/material.dart';
import 'package:my_grocery/controller/controllers.dart';
import 'package:my_grocery/extention/string_extention.dart';

import '../../../component/input_outline_button.dart';
import '../../../component/input_text_button.dart';
import '../../../component/input_text_field.dart';
import 'sign_in_screen.dart';

// Represents the Sign Up Screen in the application
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

// State class for the Sign Up Screen
class _SignUpScreenState extends State<SignUpScreen> {
  // Form key for managing the state of the form
  final _formKey = GlobalKey<FormState>();
  // Controllers for handling full name, email, password, and confirm password input
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers when the widget is disposed
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // Form for managing user input
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  "Create Account,",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Sign up to get started!",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2),
                ),
                const Spacer(
                  flex: 3,
                ),
                // Input fields for full name, email, password, and confirm password
                InputTextField(
                  title: 'Full Name',
                  textEditingController: fullNameController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
                  title: 'Email',
                  textEditingController: emailController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    } else if (!value.isValidEmail) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
                  title: 'Password',
                  obsecureText: true,
                  textEditingController: passwordController,
                  validation: (String? value) {
                    List<String> validation = [];
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    } else {
                      if (!value.isValidPasswordHasNumber) {
                        validation.add("Must contain 1 number");
                      }
                      if (!value.isValidPasswordHasCapitalLetter) {
                        validation.add("Must contain 1 capital letter");
                      }
                      if (!value.isValidPasswordHasLowerCaseLetter) {
                        validation.add("Must contain 1 lowercase letter");
                      }
                      if (!value.isValidPasswordHasSpecialCharacter) {
                        validation.add(
                            "Must contain 1 special character [! @ # \$ %]");
                      }
                    }
                    String msg = '';
                    if (validation.isNotEmpty) {
                      for (var i = 0; i < validation.length; i++) {
                        msg = msg + validation[i];
                        if ((i + 1) != validation.length) {
                          msg = "$msg\n";
                        }
                      }
                    }
                    return msg.isNotEmpty ? msg : null;
                  },
                ),
                const SizedBox(height: 10),
                InputTextField(
                  title: 'Confirm Password',
                  obsecureText: true,
                  textEditingController: confirmController,
                  validation: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "This field can't be empty";
                    } else if (passwordController.text != value) {
                      return "Confirm password does not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Spacer(),
                // Sign Up button
                InputTextButton(
                  title: "Sign Up",
                  onClick: () {
                    if (_formKey.currentState!.validate()) {
                      authController.signUp(
                        fullName: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                // Back button
                InputOutlineButton(
                  title: "Back",
                  onClick: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(
                  flex: 5,
                ),
                // Sign In link for existing members
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("I'm already a member, "),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
