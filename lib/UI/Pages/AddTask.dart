import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Models/NoteModel.dart';
import 'package:keep_tasks/Core/Classes/Themes/MyTheme.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key, this.taskModel}) : super(key: key);
  TaskModel? taskModel = TaskModel();
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  // String? editTime;

  var formatter = new DateFormat('d MMM, yyyy - hh:mm a');
  TextEditingController catcont = TextEditingController();
  TextEditingController titlecont = TextEditingController();
  TextEditingController discrpcont = TextEditingController();
  TextEditingController dueDatecont = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.taskModel != null) {
      catcont.text = widget.taskModel!.category!;
      titlecont.text = widget.taskModel!.title!;
      dueDatecont.text = widget.taskModel!.dueDate!;
      discrpcont.text = widget.taskModel!.discrp!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? editTime;
    if (widget.taskModel != null) {
      Timestamp gettime = widget.taskModel!.editTime!;

      editTime = DateFormat.yMd().add_jm().format(gettime.toDate());
    }
    Size size = MediaQuery.of(context).size;
    return Consumer<TasksProvider>(
      builder: (context, task, child) => Scaffold(
        backgroundColor: MyThemes.MyTheme.colorScheme.onPrimary,
        appBar: AppBar(
          title: Text(widget.taskModel != null ? "Update Task" : "Add Task"),
          actions: [
            IconButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  await task.addCategory(category: catcont.text);

                  await addData();
                  await task.getTasks();
                }
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TypeAheadFormField(
                            hideOnEmpty: true,
                            textFieldConfiguration: TextFieldConfiguration(
                                style: TextStyle(fontSize: 14),
                                controller: catcont,
                                decoration:
                                    Utils.MytextField(Label: "Category")),
                            suggestionsCallback: (pattern) {
                              return task.catlist.where((element) => element
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
                              if (value!.isEmpty || value == null) {
                                return 'Select Category';
                              } else
                                return null;
                            },
                          ),
                          SizedBox(height: 20),
                          DateTimeField(
                            decoration: Utils.MytextField(Label: "Due Date"),
                            controller: dueDatecont,
                            format: formatter,
                            onShowPicker: (context, currentValue) async {
                              final date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              if (date != null) {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      currentValue ?? DateTime.now()),
                                );

                                return DateTimeField.combine(date, time);
                              } else {
                                print(currentValue);
                                return currentValue;
                              }
                            },
                            validator: (value) {
                              if (dueDatecont.text.isEmpty) {
                                return "Select Time";
                              } else
                                return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return "Enter Title";
                              } else
                                return null;
                            },
                            decoration: Utils.MytextField(
                              Label: "Title",
                            ),
                            onChanged: (value) {
                              print(value);
                            },
                            controller: titlecont,
                          ),
                          SizedBox(height: 20),
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
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return " Answer should not be empty";
                                  //   } else {
                                  //     null;
                                  //   }
                                  // },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Discrption",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    print(value);
                                  },
                                  controller: discrpcont,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: 2,
            ),
            if (widget.taskModel != null)
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text("Edited on $editTime"),
                    IconButton(
                        onPressed: () async {
                          widget.taskModel!.reff!.delete();
                          await task.getTasks();

                          Navigator.pop(context);
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  addData() async {
    print("Adding ");
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    print("dialogue ");
    print(FirebaseAuth.instance.currentUser!.uid);
    try {
      if (widget.taskModel == null) {
        TaskModel taskModel = TaskModel(
          editTime: Timestamp.now(),
          userID: FirebaseAuth.instance.currentUser!.uid,
          category: catcont.text,
          title: titlecont.text,
          dueDate: dueDatecont.text,
          discrp: discrpcont.text,
        );

        await FirebaseFirestore.instance
            .collection("Tasks")
            .add(taskModel.toMap())
            .then((value) {
          Navigator.popUntil(context, (route) => route.isFirst);

          catcont.clear();
          titlecont.clear();
          discrpcont.clear();
          dueDatecont.clear();

          print("Added successfully");
        });
      } else {
        widget.taskModel!.category = catcont.text;
        widget.taskModel!.title = titlecont.text;
        widget.taskModel!.dueDate = dueDatecont.text;
        widget.taskModel!.discrp = discrpcont.text;
        widget.taskModel!.editTime = Timestamp.now();

        widget.taskModel!.reff!.set(widget.taskModel!.toMap()).then(
              (value) => Navigator.popUntil(context, (route) => route.isFirst),
            );
      }
      print("try ended");
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }
}
