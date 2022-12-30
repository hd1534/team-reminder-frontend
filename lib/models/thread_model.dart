// ignore_for_file: unnecessary_this

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
  String contents; // markdwon
  int? order;
  List<String>? tags;
  DateTime? createdDate;

  ThreadModel({
    required this.id,
    required this.name,
    required this.contents,
    this.order,
    this.tags,
    this.createdDate,
  });

  ThreadModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        contents = json['contents'],
        order = json['order'],
        tags = json['tags']?.cast<String>(),
        createdDate = (json['createdDate'] as int?)?.toDateTime();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['contents'] = this.contents;
    data['order'] = this.order;
    data['tags'] = this.tags;
    data['createdDate'] = this.createdDate?.millisecondsSinceEpoch;

    return data;
  }
}
