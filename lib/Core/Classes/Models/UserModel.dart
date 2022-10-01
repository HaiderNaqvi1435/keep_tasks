import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? email, name;
  DocumentReference? uref;

  UserData({this.email, this.name, this.uref});

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
