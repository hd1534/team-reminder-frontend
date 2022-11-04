// ignore_for_file: unnecessary_this

class VoteItem {
  String? name;
  List<String>? votedMember;

  VoteItem({this.name, this.votedMember});

  VoteItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    votedMember = json['votedMember']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = this.name;
    data['votedMember'] = this.votedMember;

    return data;
  }
}
