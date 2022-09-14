import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? title, userID, category, sDate, eDate, discrp;
  Timestamp? editTime;
  bool? isDone = false;
  DocumentReference? reff;
  TaskModel(
      {this.category,
      this.title,
      this.reff,
      this.discrp,
      this.sDate,
      this.eDate,
      this.userID,
      this.editTime});

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "title": title,
      "userID": userID,
      "editTime": editTime,
      "sDate": sDate,
      "eDate": eDate,
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
        eDate = map["eDate"],
        isDone = map["isDone"],
        discrp = map["discrp"];
}
