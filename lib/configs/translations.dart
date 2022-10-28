import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // err
          "error": "error",
          "firebaseError": "Firebase Error",

          // page
          "appName": "Team Reminder",
        },
        'ko_KR': {
          // 에러
          "error": "뭔가 잘못됨...",
          "firebaseError": "파이어베이스 연동에 실패했습니다.",

          // page
          "appName": "팀 리마인더",
        }
      };
}
