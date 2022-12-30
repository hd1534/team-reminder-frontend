import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:team_reminder_frontend/models/user_model.dart';

class UserController extends GetxController {
  // null is main home
  final _currentUser = Rx<UserModel?>(null);

  Map<String, String> get myGroups {
    final data = _currentUser.value?.groups;

    if (data == null) {
      updateUsersGroups();
    }

    return data ?? {};
  }

  void updateUsersGroups() {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    var ref = FirebaseDatabase.instance.ref('users/$userId');
  }
}

void updateUserInfo(String userId, Map<String, dynamic> data) async {
  var ref = FirebaseDatabase.instance.ref('users/$userId');

  await ref.update(data);
}
