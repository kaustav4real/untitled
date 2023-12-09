import 'package:get/get.dart';
import 'package:untitled/database/box_and_key_names.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:hive_flutter/hive_flutter.dart';

final Box box=Hive.box(userBox);
class AuthController extends GetxController {

  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    _loadAuthStatus();
    super.onInit();
  }

  void _loadAuthStatus() {
    final d = getUserInfo();
    print(d);
    isLoggedIn.value=d;
  }

  void login() {
    isLoggedIn.value = true;
    box.put(userAuthenticated,true);
  }

  void logout() {
    isLoggedIn.value = false;
    box.put(userAuthenticated, false);
  }
}
