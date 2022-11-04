// ignore_for_file: unnecessary_this

import 'package:team_reminder_frontend/models/member_model.dart';
import 'package:team_reminder_frontend/models/thread_model.dart';

class GroupModel {
  String name;
  String hash;
  List<MemberModel> members;
  List<String> tags;
  Map<String, ThreadModel> threads;

  GroupModel({
    required this.name,
    required this.hash,
    required this.members,
    this.tags = const [],
    this.threads = const <String, ThreadModel>{},
  });

  GroupModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        hash = json['hash'],
        members = List<MemberModel>.from(
            json['members']!.map((v) => MemberModel.fromJson(v))),
        tags = json['tags']?.cast<String>(),
        threads = {
          for (MapEntry<String, dynamic> e in json['threads'].entries)
            e.key: ThreadModel.fromJsonFactory(e.value)
        };

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = this.name;
    data['hash'] = this.hash;
    data['members'] = this.members.map((v) => v.toJson()).toList();
    data['tags'] = this.tags;

    return data;
  }
}
