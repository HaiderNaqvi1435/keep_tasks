import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:keep_tasks/UI/Pages/auth_Pages/Login.dart';
import 'package:provider/provider.dart';
class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}
class _MyDrawerState extends State<MyDrawer> {
  bool selected = false;
  TextEditingController addCatcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
      builder: (context, task, child) => Drawer(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  Keep Tasks",
                    style: Utils.appName(),
                  ),
                  ListTile(
                    title: Text(
                      task.userData.name ?? "",
                      style: Utils.normalText(bold: true),
                    ),
                    subtitle: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: Utils.normalText(bold: true, size: 14),
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
                                style: Utils.normalText(
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
                        icon: const Icon(
                          Icons.add_box,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: task.catlist.length,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      setState(() {
                        task.sortedList = task.taskList
                            .where((element) =>
                                element.category == task.catlist[index])
                            .toList();
                      });
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    dense: true,
                    selectedTileColor: Color.fromARGB(255, 246, 194, 202),
                    selected: selected,
                    leading: const Icon(
                      Icons.label_important,
                    ),
                    title: Text(
                      task.catlist[index],
                      style: Utils.normalText(),
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
