import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/messages.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/state_management/user_auth.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Future<void> login() async {
      final Map<String, dynamic> data = {
        'email': emailController.text,
        'password': passwordController.text,
      };

      displaySnackBar(String message) {
        final snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      final response = await http.post(
        Uri.parse('$apiBaseUrl/auth/authenticate'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extract values of "token" and "name" fields
        String token = responseData['token'];
        String name = responseData['name'];

        authController.login(
          UserLocalInfo(
            userName: emailController.text,
            fullName: name,
            token: token,
          ),
        );
      } else if (response.statusCode == 403) {
        displaySnackBar(loginErrorMessage);
      } else {
        displaySnackBar(unexpectedMessage);
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06),
      height: 300,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Set BorderSide to none
                borderRadius: BorderRadius.circular(100),
              ),
              filled: true,
              fillColor: const Color(0XFFf0f1f4),
              hintText: 'Email', // Use labelText instead of label
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none, // Set BorderSide to none
                borderRadius: BorderRadius.circular(100),
              ),
              filled: true,
              fillColor: const Color(0XFFf0f1f4),
              hintText: 'Password', // Use labelText instead of label
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              onPressed: () async {
                await login();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text('Log In'),
            ),
          )
        ],
      ),
    );
  }
}
