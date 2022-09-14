import 'package:flutter/material.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:keep_tasks/UI/Pages/AddTask.dart';
import 'package:keep_tasks/UI/Pages/Items/Drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double borderradius = 10;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyThemes.MyTheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: MyThemes.MyTheme.colorScheme.background,
        elevation: 0,
        iconTheme:
            IconThemeData(color: MyThemes.MyTheme.colorScheme.onSecondary),
        title: Text(
          "Keep Tasks",
        ),
        titleTextStyle: Utils.appName(
            color: MyThemes.MyTheme.colorScheme.onSecondary,
            // bold: true,
            size: 18),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            TextFormField(
              style: Utils.normalText(
                color: MyThemes.MyTheme.colorScheme.onSecondary,
              ),
              decoration: InputDecoration(
                  // icon: Icon(Icons.search),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderradius))),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderradius))),
                    onPressed: () {},
                    child: Text("Task 1"),
                  ),
                ),
                itemCount: 10,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 15,
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTask(update: true),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderradius),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      height: MediaQuery.of(context).size.height / 4,
                      // color: Colors.black,

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    "Task Title  ",
                                    style: Utils.normalText(
                                      color: Colors.black,
                                      bold: true,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Category",
                                    style: Utils.normalText(
                                      color:
                                          MyThemes.MyTheme.colorScheme.primary,
                                      bold: true,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text("20 aug 2022, 2:30pm"),
                            Divider(
                              thickness: 1,
                            ),
                            // Flexible(
                            //     child: ConstrainedBox(
                            //   constraints: BoxConstraints(
                            //     minWidth: size.width,
                            //     maxWidth: size.width,
                            //     minHeight: 25.0,
                            //     maxHeight: 200.0,
                            //   ),
                            //   child:
                            // )),
                            Text(
                              maxLines: 7,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              "Task Title Task TitleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k Title itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k   ",
                              style: Utils.normalText(
                                color: Colors.black,
                                size: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyThemes.MyTheme.colorScheme.primary,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTask(),
              ));
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: MyThemes.MyTheme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
