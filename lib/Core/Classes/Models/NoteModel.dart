import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? userID, category, sDate, eDate, discrp;
  Timestamp? editTime;

  TaskModel(
      {this.category,
      this.discrp,
      this.sDate,
      this.eDate,
      this.userID,
      this.editTime});

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "userID": userID,
      "editTime": editTime,
      "sDate": sDate,
      "eDate": eDate,
      "discrp": discrp,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map)
      : category = map["category"],
        userID = map["userID"],
        editTime = map["editTime"],
        sDate = map["sDate"],
        eDate = map["eDate"],
        discrp = map["discrp"];
}
