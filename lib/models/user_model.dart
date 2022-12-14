// ignore_for_file: unnecessary_this

class UserModel {
  String id;
  String name;
  String? email;
  String? photoURL;

  /// group id, name
  Map<String, String> groups;

  UserModel(
      {required this.id,
      required this.name,
      this.email,
      this.photoURL,
      this.groups = const {}});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        photoURL = json['photoURL'],
        groups = json['groups'] ?? {};

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photoURL'] = this.photoURL;
    data['groups'] = groups;

    return data;
  }
}
