import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:untitled/database/box_and_key_names.dart';
import 'package:untitled/models/user_model.dart';
import 'package:untitled/screens/dash_board.dart';

import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/state_management/user_auth.dart';
import 'package:untitled/theme.dart';

Future<void> main() async{
  WidgetsFlutterBinding();


  await Hive.initFlutter();

  Hive.registerAdapter(UserLocalInfoAdapter());

  await Hive.openBox(userBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final AuthController authController = Get.put(AuthController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
        home: Obx(() {
          if (authController.isLoggedIn.value) {
            return const DashBoard();
          } else {
            return const LoginScreen();
          }
        }));
  }
}
