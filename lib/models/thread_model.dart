// ignore_for_file: unnecessary_this

extension IntExt on int {
  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}

class ThreadModel {
  String id;
  String name;
  String contents; // markdwon
  DateTime? createdDate;

  ThreadModel({
    required this.id,
    required this.name,
    required this.contents,
    this.createdDate,
  });

  ThreadModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        contents = json['contents'],
        createdDate = (json['createdDate'] as int?)?.toDateTime();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['contents'] = this.contents;
    data['createdDate'] = this.createdDate?.millisecondsSinceEpoch;

    return data;
  }
}
