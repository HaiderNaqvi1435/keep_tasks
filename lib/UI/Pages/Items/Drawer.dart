import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
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
  bool selected = false;
  TextEditingController addCatcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, task, child) => Drawer(
          // backgroundColor: MyThemes.MyTheme.colorScheme.primary,
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: Column(
            children: [
              Container(
                // color: MyThemes.MyTheme.colorScheme.primary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  Keep Tasks",
                      style: Utils.appName(),
                    ),
                    Container(
                      child: ListTile(
                        title: Text(
                          task.userData.name!,
                          style: Utils.normalText(bold: true),
                        ),
                        subtitle: Text(
                          FirebaseAuth.instance.currentUser!.email.toString(),
                          style: Utils.normalText(bold: true, size: 14),
                        ),
                      ),
                      // child: UserAccountsDrawerHeader(
                      //     currentAccountPicture: CircleAvatar(),
                      //     accountEmail: Text(
                      //       FirebaseAuth.instance.currentUser!.email
                      //           .toString(),
                      //       style: Utils.normalText(bold: true),
                      //     ),
                      //     accountName: Text(
                      //       task.userData.name!,
                      //       style: Utils.normalText(bold: true),
                      //     )),
                    ),
                    Divider(
                      height: 0,
                      // color: MyThemes.MyTheme.colorScheme.onPrimary,
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                actionsPadding:
                                    EdgeInsets.only(right: 20, bottom: 20),
                                elevation: 5,
                                title: Text(
                                  "New Category",
                                  style: Utils.normalText(
                                      // color: MyThemes
                                      //     .MyTheme.colorScheme.primary
                                      ),
                                ),
                                content: TextFormField(
                                  controller: addCatcont,
                                  decoration: Utils.authField(label: ""),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await task.addCategory(
                                            category: addCatcont.text);
                                        Navigator.of(context).pop();

                                        await task.getCategories();
                                      },
                                      child: Text("Add")),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.add_box,
                            // color: MyThemes.MyTheme.colorScheme.onPrimary,
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
                  itemCount: task.catlist.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      setState(() {
                        // selected = true;
                        task.sortedList = task.taskList
                            .where((element) =>
                                element.category == task.catlist[index])
                            .toList();
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    dense: true,
                    selectedTileColor: Color.fromARGB(255, 246, 194, 202),
                    selected: selected,
                    // iconColor: MyThemes.MyTheme.colorScheme.onPrimary,
                    leading: Icon(
                      Icons.label_important,
                    ),
                    title: Text(
                      task.catlist[index],
                      style: Utils.normalText(),
                    ),
                  ),
                ),
              ),
              Container(
                // color: MyThemes.MyTheme.colorScheme.primary,
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: [
                    Divider(
                      // height: 50,
                      // color: MyThemes.MyTheme.colorScheme.onPrimary,
                      thickness: 2,
                    ),

                    // ListTile(
                    //   dense: true,
                    //   iconColor: MyThemes.MyTheme.colorScheme.onPrimary,
                    //   // style: ListTileStyle.drawer,
                    //   leading: Icon(
                    //     Icons.settings_outlined,
                    //   ),
                    //   title: Text(
                    //     "Settings",
                    //     style: Utils.normalText(),
                    //   ),
                    // ),

                    ListTile(
                      dense: true,
                      trailing: CupertinoSwitch(
                        value: task.isDark,
                        onChanged: (value) {
                          task.isDarkTheme(value: value);
                        },
                      ),
                      title: Text(
                        "Dark Mode",
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
                      // iconColor: MyThemes.MyTheme.colorScheme.onPrimary,
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
//

}
