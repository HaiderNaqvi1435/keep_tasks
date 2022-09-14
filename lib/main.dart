import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Database/AuthProviders.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:provider/provider.dart';

import 'Core/Classes/Database/TasksProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<TasksProvider>(
          create: (context) => TasksProvider(),
        ),
      ],
      child: MaterialApp(
        theme: MyThemes.MyTheme,
        home: AuthManager().loginservice(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
