class UserData {
  String? email, name;

  UserData({this.email, this.name});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
    };
  }

  UserData.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        email = map["email"];
}
