import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // bool isDark = false;
  // isDarkTheme({bool value = false}) {
  //   isDark = value;
  //   print(isDark);
  //   notifyListeners();
  // }

  TaskModel taskModel = TaskModel();
  UserData userData = UserData();
  getUser() async {
    FirebaseFirestore.instance
        .collection("UserData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userData = UserData.fromMap(value.data()!);
      userData.uref = value.reference;
      notifyListeners();
    });
    notifyListeners();
  }

  List<TaskModel> sortedList = [];
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
      notifyListeners();
      print(catlist);
    });
    notifyListeners();
  }

  addCategory({String? category}) async {
    bool isAvail = catlist.contains(category);
    if (isAvail == true) {
      print("Alreay in Category");
      getTasks();
      getCategories();
      notifyListeners();
    } else {
      print("adding category");
      var data = {"category": category};
      await FirebaseFirestore.instance
          .collection("UserData")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("Categories")
          .add(data)
          .then((value) {
        print("added");
      });
      getTasks();
      getCategories();
      notifyListeners();
    }
  }

  List<TaskModel> taskList = [];
  getTasks() async {
    print("Getting tasks");
    await FirebaseFirestore.instance
        .collection("Tasks")
        .where("userID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      print(value.size);
      taskList = List.generate(value.size, (index) {
        TaskModel taskModel = TaskModel.fromMap(value.docs[index].data());
        taskModel.reff = value.docs[index].reference;
        return taskModel;
      });
      sortedList.clear();
      sortedList = List.from(taskList);
      print("Got tasks");
      notifyListeners();
    });
    notifyListeners();
  }
}
