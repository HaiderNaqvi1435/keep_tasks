import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? title, userID, category, discrp;
  Timestamp? editTime;
  Timestamp? sDate;
  bool? isDone = false;
  DocumentReference? reff;
  TaskModel(
      {this.category,
      this.title,
      this.reff,
      this.discrp,
      this.sDate,
      this.userID,
      this.editTime});

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "title": title,
      "userID": userID,
      "editTime": editTime,
      "sDate": sDate,
      "discrp": discrp,
      "isDone": isDone,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map)
      : category = map["category"],
        title = map["title"],
        userID = map["userID"],
        editTime = map["editTime"],
        sDate = map["sDate"],
        isDone = map["isDone"],
        discrp = map["discrp"];
}
