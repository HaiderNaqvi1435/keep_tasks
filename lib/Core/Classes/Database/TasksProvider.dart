import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Models/NoteModel.dart';

class TasksProvider with ChangeNotifier {
  addTask(TaskModel tasks) async {
    await FirebaseFirestore.instance
        .collection("Tasks")
        .add(tasks.toMap())
        .then((value) {
      print("Added successfully");
    });
  }
}
