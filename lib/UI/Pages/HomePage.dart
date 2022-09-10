import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:keep_tasks/UI/Pages/Items/Drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyThemes.MyTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: MyThemes.MyTheme.colorScheme.background,
        elevation: 0,
        iconTheme:
            IconThemeData(color: MyThemes.MyTheme.colorScheme.onSecondary),
            title: Text("Keep "),
      ),
      drawer: MyDrawer(),
    );
  }
}
