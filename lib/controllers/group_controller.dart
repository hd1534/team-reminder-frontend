import 'dart:developer' as dev;

import 'dart:async';

import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:team_reminder_frontend/configs/constants.dart';

import 'package:team_reminder_frontend/controllers/data_load_mixin.dart';

import 'package:team_reminder_frontend/models/group_model.dart';

class GroupController extends GetxController with DataLoadMixin {
  // null is main home
  final _myGroups = RxMap<String, String>();
  Map<String, String> get myGroups => _myGroups;

  final _currentGroup = Rx<GroupModel?>(null);
  GroupModel? get currentGroup => _currentGroup.value;

  StreamSubscription<DatabaseEvent>? _myGroupsSub;

  void changeGroup(String groupId) {
    fetchAPI("$API_GROUP_BASE_URL/$groupId");
  }

  @override
  void setData(Map<String, dynamic> json) {
    _currentGroup.value = GroupModel.fromJson(json);
  }

  void listeningMyGroups() {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return;

    // cancel previous sub
    _myGroupsSub?.cancel();

    var myGroupsRef = FirebaseDatabase.instance.ref('users/$uid/groups');
    _myGroupsSub = myGroupsRef.onValue.listen((event) {
      var data = Map<String, String>.from(event.snapshot.value as Map);

      _myGroups.addAll(data);
    });
  }
}

Future<String?> participateGroup(String code) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final userName = FirebaseAuth.instance.currentUser?.displayName;

  if (userId == null || userName == null) return 'need to login'.tr;

  var snapshot =
      await FirebaseDatabase.instance.ref('groups/$code').child('name').get();
  if (snapshot.exists == false) return 'not founeded'.tr;

  await FirebaseDatabase.instance.ref().update({
    'users/$userId/groups/$code': snapshot.value,
    'groups/$code/members/$userId': userName,
  });
  return null;
}

Future<String?> createGroup(String groupName) async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final userName = FirebaseAuth.instance.currentUser?.displayName;

  if (userId == null || userName == null) return 'need to login'.tr;

  var groupKey = FirebaseDatabase.instance.ref().child('groups').push().key;

  await FirebaseDatabase.instance.ref().update({
    'users/$userId/groups/$groupKey': groupName,
    'groups/$groupKey': {
      'name': groupName,
      'admin': {userId: userName},
      'members': {userId: userName},
      'threads': {}
    }
  });

  return null;
}
