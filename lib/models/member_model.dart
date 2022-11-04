// ignore_for_file: unnecessary_this

class MemberModel {
  String id;
  String name;
  String? email;

  MemberModel({required this.id, required this.name, this.email});

  MemberModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;

    return data;
  }
}
