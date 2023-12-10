import 'package:get/get.dart';
import 'package:untitled/database/box_and_key_names.dart';
import 'package:untitled/database/user_model_db__functions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/models/user_model.dart';

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
    isLoggedIn.value=d;
  }

  void login(UserLocalInfo info) {
    isLoggedIn.value = true;
    box.put(userAuthenticated,info);

  }

  void logout() {
    isLoggedIn.value = false;
    box.delete(userAuthenticated);
  }
}
