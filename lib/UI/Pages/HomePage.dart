import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/intl.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
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
  var formatter = DateFormat('d MMM, yyyy - hh:mm a');
  double borderradius = 10;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<TasksProvider>(
      builder: (context, task, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Praxis Planner",
          ),
        ),
        drawer: MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Color.fromARGB(255, 62, 70, 175),
                controller: searchcont,
                style: Utils.normalText(),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 62, 70, 175),
                    ),
                    hintText: "Search",
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 62, 70, 175),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //   color: Color.fromARGB(255, 62, 70, 175),
                      // ),
                      borderRadius: BorderRadius.circular(50),
                    )),
                onChanged: ((value) {
                  setState(() {
                    task.sortedList = task.taskList
                        .where((element) => element.title!.contains(value))
                        .toList();
                  });
                }),
              ),
              const SizedBox(height: 8),
              if (task.catlist.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 62, 70, 175),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderradius))),
                        onPressed: () {
                          task.sortList(index: index);
                        },
                        child: Text(task.catlist[index]),
                      ),
                    ),
                    itemCount: task.catlist.length,
                  ),
                ),
              Expanded(
                flex: 12,
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
                            title: Text(
                              task.sortedList[index].title ?? "",
                              style: Utils.normalText(
                                size: 16,
                                bold: true,
                              ),
                            ),
                            subtitle: Text(
                              task.sortedList[index].dueDate ?? "",
                              style: Utils.normalText(
                                size: 14,
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () async {
                                  QuillController quillcont = QuillController(
                                      document: Document.fromJson(jsonDecode(
                                          task.sortedList[index].discrp)),
                                      selection: const TextSelection.collapsed(
                                          offset: 0));
                                  await FlutterShare.share(
                                    title: task.sortedList[index].title!,
                                    text:
                                        "${task.sortedList[index].title} \n${quillcont.document.toPlainText()}",
                                  );
                                },
                                icon: const Icon(Icons.share)),
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
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTask(),
                ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  // sharetask() async {
  //   await FlutterShare.share(title: "sdsad", text: "sdsadas");
  // }
}
