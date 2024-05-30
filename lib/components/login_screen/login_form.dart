import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/models/user_model.dart';
import 'dart:convert';

import 'package:untitled/state_management/user_auth.dart';

import '../../constants.dart';


const String loginErrorMessage = 'Login failed!';
const String unexpectedMessage = 'Unexpected error occurred!';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthController authController = Get.find<AuthController>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisible = false;
  bool loading=false;

  displaySnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> login() async {
    setState(() {
      loading=true;
    });

    final Map<String, dynamic> data = {
      'username': emailController.text.replaceAll(' ', ''),
      'password': passwordController.text,
    };

    final response = await http.post(
      Uri.parse('$apiBaseUrl/auth/authenticate'),
      body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
    );

    setState(() {
      loading=false;
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      String token = responseData['token'];
      String name = responseData['name'];

      authController.login(
        UserLocalInfo(
          userName: emailController.text,
          fullName: name,
          token: token,
        ),
      );

      // Perform action after successful login
      // For example: Redirect to a new screen or set user data in controller
    } else if (response.statusCode == 403) {
      displaySnackBar(loginErrorMessage);
    } else {
      displaySnackBar(unexpectedMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            style: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(

              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(100),
              ),
              filled: true,
              fillColor: const Color(0XFFf0f1f4),
              hintText: 'Username',
              hintStyle: Theme.of(context).textTheme.labelMedium,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: passwordController,
            obscureText: !passwordVisible,
            style: Theme.of(context).textTheme.titleMedium,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(100),
              ),
              filled: true,
              fillColor: const Color(0XFFf0f1f4),
              hintText: 'Password',
              hintStyle: Theme.of(context).textTheme.labelMedium,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              suffixIcon: IconButton(
                icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 50),
          loading? const CircularProgressIndicator():const SizedBox.shrink(),
          const SizedBox(height: 20),
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
              child: Text('Log In', style: Theme.of(context).textTheme.titleMedium,),
            ),
          ),
        ],
      ),
    );
  }
}