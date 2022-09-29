import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? email, name;
  bool? isdark;
  DocumentReference? uref;

  UserData({this.email, this.name, this.isdark, this.uref});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "isdark": isdark,
      "name": name,
    };
  }

  UserData.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        isdark = map["isdark"],
        email = map["email"];
}
