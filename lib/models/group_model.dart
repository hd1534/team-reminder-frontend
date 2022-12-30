// ignore_for_file: unnecessary_this

import 'package:team_reminder_frontend/models/user_model.dart';
import 'package:team_reminder_frontend/models/thread_model.dart';

class GroupModel {
  String id;
  String name;
  List<UserModel> members;
  List<ThreadModel> threads;

  GroupModel({
    required this.id,
    required this.name,
    required this.members,
    this.threads = const [],
  });

  GroupModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        members = List<UserModel>.from(((json['members'] ?? {}) as Map)
                .entries
                .map((e) => UserModel.fromJson({'id': e.key, ...e.value})))
            .toList(),
        threads = List<ThreadModel>.from(((json['threads'] ?? {}) as Map)
                .entries
                .map((e) => ThreadModel.fromJson({'id': e.key, ...e.value})))
            .toList();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['members'] = this.members.map((v) => v.toJson()).toList();
    data['threads'] = this.threads.map((v) => v.toJson()).toList();

    return data;
  }
}
