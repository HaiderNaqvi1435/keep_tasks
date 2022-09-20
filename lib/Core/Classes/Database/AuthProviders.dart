import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:keep_tasks/UI/Pages/auth_Pages/VerifyEmail.dart';

import '../../../UI/Pages/auth_Pages/Login.dart';

class AuthManager {
  loginservice() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return VerifyEmail();
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
