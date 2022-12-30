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

          // login
          "login": "login",
        },
        'ko_KR': {
          // 에러
          "error": "에러",
          "firebaseError": "파이어베이스 연동에 실패했습니다.",
          "need to login": "로그인이 필요합니다.",
          "not founeded": "찾을 수 없습니다.",

          // page
          "appName": "팀 리마인더",

          // login
          "login": "로그인",

          // group
          "cancel": "취소",
          "add group": "그룹 추가",
          "create new": "새로 만들기",
          "create group": "그룹 만들기",
          "name of the new group": "새로운 그룹 이름",
          "type the invitation code": "초대 코드릅 입력해주세요",
        }
      };
}
