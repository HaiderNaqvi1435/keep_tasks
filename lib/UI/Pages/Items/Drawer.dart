import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Models/UserModel.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:keep_tasks/UI/Pages/auth_Pages/Login.dart';
import 'package:provider/provider.dart';

import '../../../Core/Classes/Themes/MyTheme.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  // UserData userData = UserData();
  // getuser() async {
  //   print("Getting user");
  //   await FirebaseFirestore.instance
  //       .collection("UserData")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     userData = UserData.fromMap(value.data()!);
  //     setState(() {});
  //   });
  // }

  // void initState() {
  //   getuser();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, value, child) => Drawer(
          backgroundColor: MyThemes.MyTheme.colorScheme.primary,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Column(
                children: [
                  Container(
                    color: MyThemes.MyTheme.colorScheme.primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "  Keep Tasks",
                          style: Utils.appName(),
                        ),
                        Container(
                          child: UserAccountsDrawerHeader(
                              currentAccountPicture: CircleAvatar(),
                              accountEmail: Text(
                                FirebaseAuth.instance.currentUser!.email
                                    .toString(),
                                style: Utils.normalText(bold: true),
                              ),
                              accountName: Text(
                                "name",
                                style: Utils.normalText(bold: true),
                              )),
                        ),
                        Divider(
                          height: 0,
                          color: MyThemes.MyTheme.colorScheme.onPrimary,
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Categories",
                                style: Utils.metaText(bold: true),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add_box,
                                color: MyThemes.MyTheme.colorScheme.onPrimary,
                                size: 18,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.catlist.length,
                      itemBuilder: (context, index) => ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        dense: true,
                        selectedTileColor: Color.fromARGB(255, 246, 194, 202),
                        selected: false,
                        iconColor: MyThemes.MyTheme.colorScheme.onPrimary,
                        leading: Icon(
                          Icons.label_important,
                        ),
                        title: Text(
                          value.catlist[index],
                          style: Utils.normalText(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: MyThemes.MyTheme.colorScheme.primary,
                    height: MediaQuery.of(context).size.height / 5,
                    child: Column(
                      children: [
                        Divider(
                          // height: 50,
                          color: MyThemes.MyTheme.colorScheme.onPrimary,
                          thickness: 2,
                        ),
                        ListTile(
                          dense: true,
                          iconColor: MyThemes.MyTheme.colorScheme.onPrimary,
                          // style: ListTileStyle.drawer,
                          leading: Icon(
                            Icons.settings_outlined,
                          ),
                          title: Text(
                            "Settings",
                            style: Utils.normalText(),
                          ),
                        ),
                        ListTile(
                          onTap: (() async {
                            await FirebaseAuth.instance.signOut().then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            });
                          }),
                          dense: true,
                          iconColor: MyThemes.MyTheme.colorScheme.onPrimary,
                          // style: ListTileStyle.drawer,
                          leading: Icon(
                            Icons.settings_outlined,
                          ),
                          title: Text(
                            "Logout",
                            style: Utils.normalText(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
