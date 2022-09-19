import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Models/UserModel.dart';

import '../Models/NoteModel.dart';

class TasksProvider with ChangeNotifier {
  TasksProvider() {
    getTasks();
    getCategories();
    getUser();
  }
  TaskModel taskModel = TaskModel();
  UserData userData = UserData();
  getUser() async {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userData = UserData.fromMap(value.data()!);
      notifyListeners();
    });
  }

  List<TaskModel> sortedList = [];

  List<String> catlist = [];
  getCategories() async {
    // FirebaseDatabase.instance.ref("UserData").keepSynced(true);
    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("Categories")
        .get()
        .then((value) {
      catlist = List.generate(value.size, (index) {
        return value.docs[index].data()["category"];
      });

      notifyListeners();
      print(catlist);
    });
  }

  addCategory({String? category}) async {
    bool isAvail = catlist.contains(category);

    if (isAvail == true) {
      print("Alreay in Category");
    } else {
      print("adding category");
      var data = {"category": category};
      // FirebaseDatabase.instance.setPersistenceEnabled(true);
      await FirebaseFirestore.instance
          .collection("UserData")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Categories")
          .add(data)
          .then((value) {
        getCategories();
        notifyListeners();
        print("added");
      });
    }
  }

  List<TaskModel> taskList = [];

  getTasks() async {
    // var data;
    print("Getting tasks");
    // await FirebaseDatabase.instance.ref("Tasks").keepSynced(true);

    await FirebaseFirestore.instance
        .collection("Tasks")
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      print(value.size);
      taskList = List.generate(value.size, (index) {
        // DatabaseReference reff = FirebaseDatabase.instance.ref("AddTasks");
        // reff.onValue.listen((event) {
        //   data = event.snapshot.value;
        // });

        TaskModel taskModel = TaskModel.fromMap(value.docs[index].data());
        taskModel.reff = value.docs[index].reference;
        return taskModel;
      });
      // print(data);
      sortedList.clear();
      sortedList = List.from(taskList);
      print("Got tasks");

      notifyListeners();
    });
  }
}
