import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Models/NoteModel.dart';
import 'package:keep_tasks/Core/Classes/Models/UserModel.dart';
import 'package:provider/provider.dart';

import '../../../UI/Pages/HomePage.dart';
import '../../../UI/Pages/auth_Pages/Login.dart';

class AuthProvider with ChangeNotifier {
  addUser({String? password, UserData? userData, String? email}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((value) async {
        print("usercreat succssfully");
        FirebaseFirestore.instance
            .collection("UserData")
            .doc(value.user!.uid)
            .set(userData!.toMap());
      }).then((value) {
        FirebaseAuth.instance.signOut();
      });
    } catch (e) {
      print("Something went wrong $e");
    }
  }

  loginuser({String? password, String? email}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    } catch (e) {
      print("Something went wrong! $e");
    }
  }
}

class Auth {
  loginservice() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AuthProvider>(
                create: (context) => AuthProvider(),
              ),
              ChangeNotifierProvider<TasksProvider>(
                create: (context) => TasksProvider(),
              ),
            ],
            child: HomePage(),
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      debugPrint("Logged out successfully!");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
