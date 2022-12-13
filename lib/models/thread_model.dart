// ignore_for_file: unnecessary_this

import 'package:team_reminder_frontend/models/thread_post_model.dart';

extension IntExt on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

enum ThreadType {
  memo,
  todoList,
  vote,
}

class ThreadModel {
  String id;
  String name;
  ThreadType type;
  int? order;
  List<String>? tags;
  DateTime? createdDate;
  List<PostItem>? posts;

  ThreadModel({
    required this.id,
    required this.name,
    required this.type,
    this.order,
    this.tags,
    this.createdDate,
  });

  ThreadModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = ThreadType.values.byName(json['type']!),
        order = json['order'],
        tags = json['tags']?.cast<String>(),
        posts = List<PostItem>.from(
            json['posts']?.map((v) => PostItem.fromJson(v))),
        createdDate = (json['createdDate'] as int?)?.toDateTime();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type.name;
    data['order'] = this.order;
    data['tags'] = this.tags;
    data['posts'] = this.posts?.map((v) => v.toJson()).toList();
    data['createdDate'] = this.createdDate?.millisecondsSinceEpoch;

    return data;
  }
}

// remove below

class Memo extends ThreadModel {
  String? memo;

  Memo({
    // super
    required String id,
    required String name,
    required ThreadType type,
    int? order,
    List<String>? tags,
    DateTime? createdDate,

    // this
    this.memo,
  }) : super(
          id: id,
          name: name,
          type: type,
          order: order,
          tags: tags,
          createdDate: createdDate,
        );

  Memo.fromJson(Map<String, dynamic> json)
      : memo = json['memo'],
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{...super.toJson()};

    data['memo'] = this.memo;

    return data;
  }
}

class TodoList extends ThreadModel {
  String? memo;
  DateTime? endDate;
  DateTime? startDate;
  bool? isCompleted;
  List<String>? assigned;

  TodoList({
    // super
    required String id,
    required String name,
    required ThreadType type,
    int? order,
    List<String>? tags,
    DateTime? createdDate,

    // this
    this.memo,
    this.endDate,
    this.startDate,
    this.isCompleted,
    this.assigned,
  }) : super(
          id: id,
          name: name,
          type: type,
          order: order,
          tags: tags,
          createdDate: createdDate,
        );

  TodoList.fromJson(Map<String, dynamic> json)
      : memo = json['memo'],
        endDate = (json['endDate'] as int?)?.toDateTime(),
        startDate = (json['startDate'] as int?)?.toDateTime(),
        isCompleted = json['isCompleted'],
        assigned = json['assigned']?.cast<String>(),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{...super.toJson()};

    data['memo'] = this.memo;
    data['endDate'] = this.endDate?.millisecondsSinceEpoch;
    data['startDate'] = this.startDate?.millisecondsSinceEpoch;
    data['isCompleted'] = this.isCompleted;
    data['assigned'] = this.assigned;

    return data;
  }
}

class Vote extends ThreadModel {
  bool? isMultipleChoice;
  List<VoteItem>? items;

  Vote({
    // super
    required String id,
    required String name,
    required ThreadType type,
    int? order,
    List<String>? tags,
    DateTime? createdDate,

    // this
    this.isMultipleChoice,
    this.items,
  }) : super(
          id: id,
          name: name,
          type: type,
          order: order,
          tags: tags,
          createdDate: createdDate,
        );

  Vote.fromJson(Map<String, dynamic> json)
      : isMultipleChoice = json['isMultipleChoice'],
        items = List<VoteItem>.from(
            json['items']?.map((v) => VoteItem.fromJson(v))),
        super.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{...super.toJson()};

    data['isMultipleChoice'] = this.isMultipleChoice;
    data['items'] = this.items?.map((v) => v.toJson()).toList();

    return data;
  }
}
