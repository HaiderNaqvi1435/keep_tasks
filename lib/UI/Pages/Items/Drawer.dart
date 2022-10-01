import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Models/UserModel.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:keep_tasks/UI/Pages/auth_Pages/Login.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int? isSelected;
  TextEditingController addCatcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, task, child) => Drawer(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    title: Text(
                      "  Praxis Planner",
                      style: Utils.metaText(size: 22),
                    ),
                    leading: SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        "assets/Praxis Planner.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  ListTile(
                    title: Text(
                      task.userData.name ?? "",
                      style: Utils.metaText(size: 18, bold: true),
                    ),
                    subtitle: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: Utils.metaText(size: 14),
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 8),
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
                                  const EdgeInsets.only(right: 20, bottom: 20),
                              elevation: 5,
                              title: Text(
                                "New Category",
                                style: Utils.normalText(),
                              ),
                              content: TextFormField(
                                controller: addCatcont,
                                decoration: Utils.authField(label: ""),
                              ),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 62, 70, 175),
                                        foregroundColor: Colors.white),
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
                        icon: const Icon(
                          color: Colors.white,
                          Icons.add_box,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                  ListTile(
                    onTap: () {
                      task.sortList(index: -1);
                      setState(() {
                        isSelected = -1;
                      });
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    dense: true,
                    tileColor: isSelected == -1
                        ? Color.fromARGB(255, 172, 177, 244)
                        : null,

                    // selectedTileColor: Color.fromARGB(255, 246, 194, 202),
                    leading: const Icon(
                      Icons.label_important,
                    ),
                    title: Text(
                      "Tasks",
                      style: Utils.metaText(bold: true),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: task.catlist.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      task.sortList(index: index);
                      setState(() {
                        isSelected = index;
                      });
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    dense: true,
                    tileColor: isSelected == index
                        ? Color.fromARGB(255, 172, 177, 244)
                        : null,

                    // selectedTileColor: Color.fromARGB(255, 246, 194, 202),
                    leading: const Icon(
                      Icons.label_important,
                    ),
                    title: Text(
                      task.catlist[index],
                      style: Utils.metaText(bold: true),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 5,
                child: Column(
                  children: [
                    const Divider(
                      thickness: 2,
                    ),
                    ListTile(
                      dense: true,
                      trailing: Switch(
                        activeColor: Colors.green,
                        value: task.isDark,
                        onChanged: (value) {
                          // task.userData.isdark = value;
                          // task.userData.uref!
                          //     .set(task.userData.toMap())
                          //     .then((value) => task.getUser());
                          // print(value);
                          setState(() {
                            task.isDarkTheme(value: value);
                          });
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
                      trailing: const Icon(
                        Icons.logout,
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
