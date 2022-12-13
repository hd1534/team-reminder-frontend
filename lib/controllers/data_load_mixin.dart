import 'dart:developer' as developer;

import 'dart:io';
import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart';

import 'package:team_reminder_frontend/configs/constants.dart';

import 'package:team_reminder_frontend/configs/http.dart';

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
  '$API_THREAD_BASE_URL/test': """
{
    "id": "DataLoadMixin test",
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
"""
};
