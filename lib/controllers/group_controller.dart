import 'dart:convert';

import 'package:get/get.dart';

import 'package:team_reminder_frontend/models/group_model.dart';

class GroupController extends GetxController {
  // null is main home
  final _myGroups = RxMap<String, GroupModel>();
  final _currentGroup = Rx<GroupModel?>(null);

  get myGroupList => _myGroups;

  // TODO: caching

  void init() async {
    // pass
  }

  void changeGroup(String groupName) {
    fetchGroup(groupName);
  }

  /// dumy data
  void fetchGroup(String groupName) async {
    await Future.delayed(const Duration(seconds: 1)); // TODO: remove

    var json = jsonDecode(dummy);
    _currentGroup.value = GroupModel.fromJson(json);
  }
}

String dummy = '''
{
  "group id": {
    "id": "group id",
    "name": "group name",
    "hash": "hash for update check",
    "members": [
      {
        "id": "id",
        "name": "name",
        "email": "email@email.com",
        "Oauth": 1, // bit flag (ex: google = 1, ...)
        "permissions": [
          // ?
          { "admin": true },
          { "add": ["thread name"] },
          { "delete": ["thread name"] },
          { "manage": ["member", "thread"] }
        ]
      }
    ],
    "tags": ["backend", "database", "food", "lunch"],
    "threads": {
      "thread name": {
        "id": "id",
        "type": "memo",
        "items": [
          {
            "id": "2021-10-31.hash",
            "title": "data structure memo",
            "order": 1,
            "memo": "with dynamodb",
            "tags": ["backend", "database"]
          }
        ]
      },
      "thread name2": {
        "id": "id",
        "type": "todoList",
        "items": [
          {
            "id": "2021-10-31.hash",
            "isCompleted": false,
            "order": 1,
            "title": "create data structure",
            "memo": "with dynamodb",
            "tags": ["backend", "database"],
            "date": {
              "start": "2021-10-31",
              "end": "2022-10-31",
              "on": "2021-10-31T13:30:00"
            },
            "assigned": ["member id"]
          }
        ]
      },
      "thread name3": {
        "id": "id",
        "type": "votes",
        "items": [
          {
            "id": "2021-10-31.hash",
            "title": "lunch menu",
            "isMultipleChoice": true,
            "tags": ["food", "lunch"],
            "items": [{ "name": "pizza", "votedMember": ["member id"] }]
          }
        ]
      }
      // "schedule": {},
    }
  }
}
''';
