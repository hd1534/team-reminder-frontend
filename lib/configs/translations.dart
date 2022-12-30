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
          "group not founded": "그룹을 찾을 수 없습니다",
          "thread not founded": "쓰레드를 찾을 수 없습니다",

          // 에외
          "Select the group first.": "그룹을 먼저 선택해주세요",

          // page
          "appName": "팀 리마인더",

          // login
          "login": "로그인",
          "logout": "로그아웃",

          // group
          "cancel": "취소",
          "invite member": "멤버 초대",
          "add group": "그룹 추가",
          "create new": "새로 만들기",
          "create group": "그룹 만들기",
          "name of the new group": "새로운 그룹 이름",
          "type the invitation code": "초대 코드릅 입력해주세요",
          "sharing invite code": "초대 코드를 공유하세요",

          // thread
          "create thread": "쓰레드 만들기",
          "name of the new thread": "새로운 쓰레드 이름",
        }
      };
}
