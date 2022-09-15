import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:keep_tasks/UI/Pages/AddTask.dart';
import 'package:keep_tasks/UI/Pages/Items/Drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchcont = TextEditingController();
  var formatter = new DateFormat('d MMM, yyyy - hh:mm a');

  double borderradius = 10;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<TasksProvider>(
      builder: (context, task, child) => Scaffold(
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
                controller: searchcont,
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
                onChanged: ((value) {
                  setState(() {
                    task.sortedList = task.taskList
                        .where((element) => element.title!.contains(value))
                        .toList();
                  });
                }),
              ),
              SizedBox(height: 8),
              if (task.catlist.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderradius))),
                        onPressed: () {
                          // task.sortedList=

                          setState(() {
                            task.sortedList = task.taskList
                                .where((element) =>
                                    element.category == task.catlist[index])
                                .toList();
                          });
                        },
                        child: Text(task.catlist[index]),
                      ),
                    ),
                    itemCount: task.catlist.length,
                  ),
                ),
              Expanded(
                flex: 15,
                child: RefreshIndicator(
                  onRefresh: (() async {
                    await task.getCategories();
                    await task.getTasks();
                  }),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          //246,194,202
                          color: Color.fromARGB(255, 254, 243, 245),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddTask(
                                        taskModel: task.sortedList[index]),
                                  ));
                            },
                            // leading: Checkbox(
                            //   // value: task.taskList[index].isDone,
                            //   onChanged: (value) {
                            //     setState(() {

                            //       task.taskList[index].isDone = value;
                            //     });
                            //     print(value);
                            //   },
                            // ),
                            //  Text("${index + 1}"),
                            title: Text(
                              task.sortedList[index].title ?? "",
                              style: Utils.normalText(
                                  size: 16,
                                  color: MyThemes.MyTheme.colorScheme.primary,
                                  bold: true),
                            ),
                            subtitle: Text(
                              task.taskList[index].dueDate ?? "",
                              style: Utils.normalText(
                                  color: Colors.black54, size: 14),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: task.sortedList.length,
                  ),
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
      ),
    );
  }
}
// InkWell(
//                     onTap: () {
//
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(borderradius),
//                           border: Border.all(
//                             color: Colors.grey,
//                           )),
//                       height: MediaQuery.of(context).size.height / 4,
//                       // color: Colors.black,

//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 4,
//                                   child: Text(
//                                     softWrap: true,
//                                     overflow: TextOverflow.ellipsis,
//                                     "Task Title  ",
//                                     style: Utils.normalText(
//                                       color: Colors.black,
//                                       bold: true,
//                                       size: 18,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     "Category",
//                                     style: Utils.normalText(
//                                       color:
//                                           MyThemes.MyTheme.colorScheme.primary,
//                                       bold: true,
//                                       size: 14,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//
//                             Divider(
//                               thickness: 1,
//                             ),
//                             // Flexible(
//                             //     child: ConstrainedBox(
//                             //   constraints: BoxConstraints(
//                             //     minWidth: size.width,
//                             //     maxWidth: size.width,
//                             //     minHeight: 25.0,
//                             //     maxHeight: 200.0,
//                             //   ),
//                             //   child:
//                             // )),
//                             Text(
//                               maxLines: 7,
//                               softWrap: true,
//                               overflow: TextOverflow.ellipsis,
//                               "Task Title Task TitleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k Title itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k  itleTask TitleTask TitleTask TitleT ask TitleTask Title Task TitleTask  TitleT ask Tit leTas k   ",
//                               style: Utils.normalText(
//                                 color: Colors.black,
//                                 size: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
