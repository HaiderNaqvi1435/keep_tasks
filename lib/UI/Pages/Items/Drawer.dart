import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';

import '../../../Core/Classes/Themes/MyTheme.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                              "HaiderNaqvi1435@gmail.com",
                              style: Utils.metaText(),
                            ),
                            accountName: Text(
                              "Haider Naqvi",
                              style: Utils.metaText(),
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
                    itemCount: 10,
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
                        "Task 1 ",
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
        ));
  }
}
