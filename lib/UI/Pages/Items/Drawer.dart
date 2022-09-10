import 'package:flutter/material.dart';

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
              Text("Keep Tasks"),
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
