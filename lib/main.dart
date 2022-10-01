import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:keep_tasks/Core/Classes/Database/AuthProviders.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:provider/provider.dart';

import 'Core/Classes/Database/TasksProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksProvider>(
      create: (context) => TasksProvider(),
      child: Consumer<TasksProvider>(
        builder: (context, value, child) => MaterialApp(
          // theme: MyThemes.MyDarkTheme,

          theme: MyThemes.myTheme(value.isDark, context),
          // darkTheme: MyThemes.MyTheme(true, context),
          home: AuthManager().loginservice(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
