// ignore_for_file: unnecessary_this

class PostItem {
  String title;
  String contexts;

  PostItem({required this.title, required this.contexts});

  PostItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        contexts = json['contexts'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = this.title;
    data['contexts'] = this.contexts;

    return data;
  }
}

class VoteItem {
  String name;
  List<String> votedMember;

  VoteItem({required this.name, required this.votedMember});

  VoteItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        votedMember = json['votedMember']?.cast<String>() ?? [];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = this.name;
    data['votedMember'] = this.votedMember;

    return data;
  }
}
