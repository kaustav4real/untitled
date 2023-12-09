import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/components/dashboard_screen/dashboard_app_bar.dart';
import 'package:untitled/state_management/user_auth.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 80),
          child: const DashBoardAppBar(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  authController.logout();
                },
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
