import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? title, userID, category, dueDate;
  var discrp;
  Timestamp? editTime;

  bool? isDone = false;
  DocumentReference? reff;
  TaskModel(
      {this.category,
      this.title,
      this.reff,
      this.discrp,
      this.dueDate,
      this.userID,
      this.editTime});

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "title": title,
      "userID": userID,
      "editTime": editTime,
      "dueDate": dueDate,
      "discrp": discrp,
      "isDone": isDone,
    };
  }

  TaskModel.fromMap(Map<String, dynamic> map)
      : category = map["category"],
        title = map["title"],
        userID = map["userID"],
        editTime = map["editTime"],
        dueDate = map["dueDate"],
        isDone = map["isDone"],
        discrp = map["discrp"];
}
