import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/state_management/user_auth.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController=Get.find<AuthController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Settings', style: Theme.of(context).textTheme.titleMedium,),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.75,),
            Center(
              child: TextButton(
                onPressed: (){
                  authController.logout();
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5)
                ),
                child:  Text('Logout',style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
