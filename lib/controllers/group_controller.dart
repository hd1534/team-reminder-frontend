import 'dart:convert';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/configs/constants.dart';

import 'package:team_reminder_frontend/controllers/data_load_mixin.dart';

import 'package:team_reminder_frontend/models/group_model.dart';

class GroupController extends GetxController with DataLoadMixin {
  // null is main home
  final _currentGroup = Rx<GroupModel?>(null);

  GroupModel? get currentGroup => _currentGroup.value;

  void changeGroup(String groupId) {
    fetchAPI("$API_GROUP_BASE_URL/$groupId");
  }

  @override
  void setData(Map<String, dynamic> json) {
    _currentGroup.value = GroupModel.fromJson(json);
  }
}
