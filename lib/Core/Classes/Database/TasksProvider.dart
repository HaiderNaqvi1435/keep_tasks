import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/NoteModel.dart';

class TasksProvider with ChangeNotifier {
  TasksProvider() {
    getTasks();
  }
  List<String> catlist = [
    "Home Work",
    "Mobile app",
    "Web",
    "Other",
    "Meetings",
  ];

  List<TaskModel> taskList = [];

  getTasks() async {
    await FirebaseFirestore.instance.collection("Tasks").get().then((value) {
      print(value.size);

      taskList = List.generate(value.size, (index) {
        TaskModel taskModel = TaskModel.fromMap(value.docs[index].data());
        taskModel.reff = value.docs[index].reference;
        return taskModel;
      });
      notifyListeners();
    });
  }
}
