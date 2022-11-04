import 'dart:developer' as developer;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:team_reminder_frontend/models/group_model.dart';

import 'package:team_reminder_frontend/models/thread_model.dart';

String jsonStr = '''{
  "id": "group id",
  "name": "group name",
  "hash": "hash for update check",
  "members": [
    {
      "id": "id",
      "name": "name",
      "email": "email@email.com",
      "Oauth": 1,
      "permissions": [
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
      "title": "memo thread",
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
      "title": "todoList thread",
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
      "title": "vote thread",
      "type": "vote",
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
  }
}
''';

void main() {
  test('GroupModel.fromJson test', () {
    GroupModel test = GroupModel.fromJson(jsonDecode(jsonStr));
    developer.log('$test');
    developer.log('${test.threads}');
  });
}
