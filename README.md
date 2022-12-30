<!-- @format -->

# Team Reminder Frontend

## firebase

https://firebase.google.com/docs/flutter/setup?platform=ios
https://firebase.google.com/docs/auth/flutter/start

## 폴더 구조

```shell
lib
├── configs
├── controllers
├── init.dart
├── main.dart
├── models
├── utils
│   └── getx
└── views
```

## 디자인

일단 디스코드 같은 디자인 만들기
![discord main ui](./readme/discord%20main%20ui.jpeg)
![discord main ui](./readme/discord%20server%20ui.png)

## 구현 내용

일단 getx로: https://pub.dev/packages/get#about-get
저장은 get storage: https://pub.dev/packages/get_storage/install

localizing 은 get Translations으로

일단 글들은 infinite scroll로 해두고
데이터 패치는 어캐할지랑 로컬에 저장할지는 나중에

- https://api.flutter.dev/flutter/widgets/ListView/ListView.separated.html
- https://empering.tistory.com/entry/%EB%A7%A4%EC%9A%B0-%EA%B0%84%EB%8B%A8%ED%95%9C-%EB%AC%B4%ED%95%9C-%EC%8A%A4%ED%81%AC%EB%A1%A4-%EB%A7%8C%EB%93%A4%EA%B8%B0
- https://pub.dev/packages/infinite_scroll_pagination

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
