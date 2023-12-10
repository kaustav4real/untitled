import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/database/box_and_key_names.dart';
import 'package:untitled/models/user_model.dart';

final Box box = Hive.box(userBox);

UserLocalInfo getUserInfo() {
  final userData = box.get(
    userAuthenticated,
    defaultValue: UserLocalInfo(
      userName: '',
      fullName: '',
      token: '',
    ),
  );
  return userData as UserLocalInfo;
}
