import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Models/NoteModel.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<String> catlist = [
    "Task1",
    "Task2",
    "Task3",
    "Task4",
    "Task5",
  ];

  TextEditingController catcont = TextEditingController();
  TextEditingController discrpcont = TextEditingController();
  TextEditingController sDatecont = TextEditingController();
  TextEditingController eDatecont = TextEditingController();
  @override
  void initState() {
    sDatecont = TextEditingController(text: DateTime.now().toString());
    eDatecont = TextEditingController(text: DateTime.now().toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<TasksProvider>(
      builder: (context, task, child) => Scaffold(
        backgroundColor: MyThemes.MyTheme.colorScheme.onPrimary,
        appBar: AppBar(
          title: Text("Add Task"),
          actions: [
            IconButton(
                onPressed: () {},
                icon: IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () {
                    TaskModel taskModel = TaskModel(
                        category: catcont.text,
                        discrp: discrpcont.text,
                        eDate: eDatecont.text,
                        sDate: sDatecont.text);

                    task.addTask(taskModel);
                    print(sDatecont.text);
                    print(eDatecont.text);
                  },
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height / 10,
                        // ),
                        TypeAheadFormField(
                          hideOnEmpty: true,
                          textFieldConfiguration: TextFieldConfiguration(
                              style: TextStyle(fontSize: 14),
                              controller: catcont,
                              decoration: Utils.MytextField(Label: "Category")),
                          suggestionsCallback: (pattern) {
                            return catlist.where((element) => element
                                .toLowerCase()
                                .contains(pattern.toLowerCase()));
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion.toString()),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
                            catcont.text = suggestion.toString();
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Select Category';
                            }
                          },
                        ),
                        SizedBox(height: 20),

                        DateTimePicker(
                          type: DateTimePickerType.dateTimeSeparate,
                          // controller: sDatecont,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          dateMask: 'd MMM, yyyy',
                          dateLabelText: 'Start Date',
                          timeLabelText: "Start Time",
                          controller: sDatecont,
                          // onChanged: (val) {},
                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     sDatecont.text = DateTime.now().toString();
                          //   } else {
                          //     sDatecont.text = val;
                          //   }
                          //   print(val);
                          // },
                          // onSaved: (val) {
                          //   print(val);
                          // },
                        ),
                        SizedBox(height: 20),

                        DateTimePicker(
                          type: DateTimePickerType.dateTimeSeparate,
                          controller: eDatecont,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event),
                          dateMask: 'd MMM, yyyy',
                          dateLabelText: 'End Date',
                          timeLabelText: "End Time",
                          onChanged: (val) {},
                          validator: (val) {
                            // if (val!.isEmpty) {
                            //   eDatecont.text = DateTime.now().toString();
                            // } else {
                            //   eDatecont.text = val;
                            // }
                          },
                          onSaved: (val) {},
                        ),
                        // TextFormField(
                        //   decoration: Utils.MytextField(Label: "Title"),
                        // ),
                        SizedBox(height: 20),

                        // DatePickerDialog(initialDate: , firstDate:, lastDate: lastDate)
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: size.width,
                            maxWidth: size.width,
                            minHeight: 25.0,
                            maxHeight: MediaQuery.of(context).size.height / 2,
                          ),
                          child: Scrollbar(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return " Answer should not be empty";
                                  } else {
                                    null;
                                  }
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: Utils.MytextField(
                                  Label: "Discrption",
                                ),
                                onChanged: (value) {
                                  print(value);
                                },
                                controller: discrpcont,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 20),

                        // TextFormField(
                        //   decoration: Utils.MytextField(Label: "Title"),
                        // ),
                        // SizedBox(height: 20),

                        // TextFormField(
                        //   decoration: Utils.MytextField(Label: "Title"),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: 2,
            ),
            Container(
              height: 40,
              // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text("Edited on 9 aug 2022 at 2:30pm"),
                  IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
