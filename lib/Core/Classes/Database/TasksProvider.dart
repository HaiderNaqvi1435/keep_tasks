import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Models/NoteModel.dart';

class TasksProvider with ChangeNotifier {
  TasksProvider() {
    getTasks();
    getCategories();
  }
  List<String> catlist = [];
  getCategories() async {
    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Categories")
        .get()
        .then((value) {
      catlist = List.generate(value.size, (index) {
        return value.docs[index].data()["category"];
      });
      print("added");
    });
  }

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
