// ignore_for_file: unnecessary_this

import 'package:team_reminder_frontend/models/thread_item_model.dart';

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
  String title;
  ThreadType type;
  int? order;
  List<String>? tags;
  DateTime? createdDate;

  ThreadModel._internal({
    required this.id,
    required this.title,
    required this.type,
    this.order,
    this.tags,
    this.createdDate,
  });

  ThreadModel._fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        type = ThreadType.values.byName(json['type']!),
        order = json['order'],
        tags = json['tags']?.cast<String>(),
        createdDate = (json['createdDate'] as int?)?.toDateTime();

  factory ThreadModel.fromJsonFactory(Map<String, dynamic> json) {
    var type = ThreadType.values.byName(json['type']!);

    switch (type) {
      case ThreadType.memo:
        return Memo.fromJson(json);
      case ThreadType.todoList:
        return TodoList.fromJson(json);
      case ThreadType.vote:
        return Vote.fromJson(json);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type.name;
    data['order'] = this.order;
    data['tags'] = this.tags;
    data['createdDate'] = this.createdDate?.millisecondsSinceEpoch;

    return data;
  }
}

class Memo extends ThreadModel {
  String? memo;

  Memo({
    // super
    required String id,
    required String title,
    required ThreadType type,
    int? order,
    List<String>? tags,
    DateTime? createdDate,

    // this
    this.memo,
  }) : super._internal(
          id: id,
          title: title,
          type: type,
          order: order,
          tags: tags,
          createdDate: createdDate,
        );

  Memo.fromJson(Map<String, dynamic> json)
      : memo = json['memo'],
        super._fromJson(json);

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
    required String title,
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
  }) : super._internal(
          id: id,
          title: title,
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
        super._fromJson(json);

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
    required String title,
    required ThreadType type,
    int? order,
    List<String>? tags,
    DateTime? createdDate,

    // this
    this.isMultipleChoice,
    this.items,
  }) : super._internal(
          id: id,
          title: title,
          type: type,
          order: order,
          tags: tags,
          createdDate: createdDate,
        );

  Vote.fromJson(Map<String, dynamic> json)
      : isMultipleChoice = json['isMultipleChoice'],
        items = List<VoteItem>.from(
            json['items']?.map((v) => VoteItem.fromJson(v))),
        super._fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{...super.toJson()};

    data['isMultipleChoice'] = this.isMultipleChoice;
    data['items'] = this.items?.map((v) => v.toJson()).toList();

    return data;
  }
}
