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
      "contents": "contents",
      "name": "name"
    },
    "todoList": {
      "id": "todoList",
      "contents": "contents",
      "name": "todoList"
    },
    "vote": {
      "id": "vote",
      "contents": "contents",
      "name": "vote"
    }
  }
}
""",
  '$API_THREAD_BASE_URL/test': """
{
    "id": "test",
    "name": "name",
    "contents": "contents"
}
""",
  '$API_THREAD_BASE_URL/todoList': """
{
    "id": "todoList",
    "name": "todoList",
    "contents": "contents"
}
""",
  '$API_THREAD_BASE_URL/vote': """
{
    "id": "vote",
    "name": "vote",
    "contents": "contents"
}
"""
};
