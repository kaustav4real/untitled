import 'package:flutter/material.dart';
import 'package:untitled/state_management/user_auth.dart';
import 'package:get/get.dart';
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController=Get.find<AuthController>();
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06),
      height: 300,
      child: Column(
        children: [
          TextFormField(
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
              onPressed: () {
                authController.login();
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
