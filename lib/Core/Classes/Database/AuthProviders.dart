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

class AuthProvider with ChangeNotifier {}

class AuthManager {
  loginservice() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
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
