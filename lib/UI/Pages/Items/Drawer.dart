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
      child: ListView(
        // padding: EdgeInsets.zero,

        padding: EdgeInsets.all(16),

        children: [
          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Keep Tasks",
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
              Column(
                children: [
                  ListTile(
                    iconColor: MyThemes.MyTheme.colorScheme.onPrimary,
                    leading: Icon(
                      Icons.label_important,
                    ),
                    title: Text(
                      "Tassk 1 ",
                      style: Utils.normalText(),
                    ),
                  )
                ],
              ),
            ],
          )),
        ],
        // children: [
        //   Container(
        //     child: DrawerHeader(

        //       padding: EdgeInsets.zero,
        //       child: InkWell(
        //         onTap: () {},
        //         child: UserAccountsDrawerHeader(
        //           margin: EdgeInsets.zero,
        //           decoration: BoxDecoration(),
        //           accountName: Text(
        //             "sd",
        //           ),
        //           accountEmail: Text(
        //             "sds",
        //           ),
        //           currentAccountPicture: ClipRRect(
        //             child: Image.asset(
        //               "assets/user.png",
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        //   ListTile(
        //     onTap: () async {},
        //     leading: Icon(
        //       Icons.mail,
        //     ),
        //     title: Text(
        //       "Feedback",
        //     ),
        //   ),
        //   ListTile(
        //     onTap: () {
        //       //
        //       // Themes.mytoast("Logged out!");
        //     },
        //     leading: Icon(
        //       Icons.logout,
        //     ),
        //     title: Text(
        //       "Sign out",
        //     ),
        //   ),
        // ],
      ),
    );
  }
}
