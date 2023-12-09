import 'package:hive/hive.dart';
import 'package:untitled/database/box_and_key_names.dart';

part 'user_model.g.dart';

final box = Hive.box(userBox);

@HiveType(typeId: 1)
class UserLocalInfo {
  @HiveField(0)
  String userEmail;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String session;

  UserLocalInfo({
    required this.userEmail,
    required this.session,
    required this.userName,
  });

  Future<bool> storeUserInfo(UserLocalInfo user) async {
    try {
      await box.put(userInfo, user);
      return true;
    } catch (error) {
      return false;
    }
  }
}

retrieveUserInfo() {
  if (box.get(userInfo) != null) {
    return box.get(userInfo);
  }
  return false;
}
