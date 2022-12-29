import 'dart:developer' as developer;

import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart';

import 'package:team_reminder_frontend/configs/constants.dart';

import 'package:team_reminder_frontend/configs/http.dart';

// for caching
mixin DataLoadMixin {
  final _isCached = false.obs; // 캐시된 데이터인 경우
  final _isLoading = false.obs;

  Exception? _error;

  get isCached => _isCached;
  get isLoading => _isLoading;
  get error => _error;

  /// data: json decoded
  void setData(Map<String, dynamic> json);

  void fetchAPI(String url) async {
    try {
      // cache
      // with getx storage

      // // http request
      // var client = CustomClient(); // it seems need optimization
      // var uri = Uri.https(API_BASE_URL, url);
      // var response = await client.get(uri);
      // developer.log('Response status: ${response.statusCode}');
      // developer.log('Response body: ${response.body}');

      // TEMP: dummy data
      final json = jsonDecode(dummy[url] ?? '{}');
      setData(json);
    }

    // error handling
    on SocketException catch (e) {
      developer.log("check your internet connection");
      rethrow;
    }
  }
}

const dummy = {
  '$API_GROUP_BASE_URL/test': """
{
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
    "test": {
      "id": "test",
      "type": "memo",
      "name": "name"
    },
    "todoList": {
      "id": "todoList",
      "type": "todoList",
      "name": "todoList"
    },
    "vote": {
      "id": "vote",
      "type": "vote",
      "name": "vote"
    }
  }
}
""",
  '$API_THREAD_BASE_URL/test': """
{
    "id": "test",
    "name": "name",
    "type": "memo",
    "posts": [
      {
        "id": "2021-10-31.hash",
        "title": "DataLoadMixin test",
        "order": 1,
        "contexts": "with dynamodb",
        "tags": ["backend", "database"]
      },
      {
        "id": "2022-10-31.hash",
        "title": "12 13 tue",
        "order": 2,
        "contexts": "fadskf",
        "tags": ["backend", "database"]
      }
    ]
}
""",
  '$API_THREAD_BASE_URL/todoList': """
{
      "id": "todoList",
      "type": "todoList",
      "name": "todoList",
      "posts": [
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
    }
""",
  '$API_THREAD_BASE_URL/vote': """
{
      "id": "vote",
      "type": "vote",
      "name": "vote",
      "itemsDepricated": [
        {
          "id": "2021-10-31.hash",
          "title": "lunch menu",
          "isMultipleChoice": true,
          "tags": ["food", "lunch"],
          "itemsDepricated": [{ "name": "pizza", "votedMember": ["member id"] }]
        }
      ]
    }
"""
};
