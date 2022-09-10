import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              child: InkWell(
                onTap: () {},
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(),
                  accountName: Text(
                    "sd",
                  ),
                  accountEmail: Text(
                    "sds",
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () async {},
            leading: Icon(
              Icons.mail,
            ),
            title: Text(
              "Feedback",
            ),
          ),
          ListTile(
            onTap: () {
              //
              // Themes.mytoast("Logged out!");
            },
            leading: Icon(
              Icons.logout,
            ),
            title: Text(
              "Sign out",
            ),
          ),
        ],
      ),
    );
  }
}
