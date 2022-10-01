import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:keep_tasks/Core/Classes/Database/TasksProvider.dart';
import 'package:keep_tasks/Core/Classes/Models/NoteModel.dart';
import 'package:keep_tasks/Core/Classes/Themes/Utils.dart';
import 'package:provider/provider.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key, this.taskModel}) : super(key: key);
  TaskModel? taskModel = TaskModel();
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  bool istapped = false;
  ScrollController scrollController = ScrollController();
  QuillController quillcont = QuillController.basic();
  var formatter = DateFormat('d MMM, yyyy - hh:mm a');
  TextEditingController catcont = TextEditingController();
  TextEditingController titlecont = TextEditingController();
  TextEditingController discrpcont = TextEditingController();
  TextEditingController dueDatecont = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool toolbar = false;
  @override
  void initState() {
    if (widget.taskModel != null) {
      catcont.text = widget.taskModel!.category!;
      titlecont.text = widget.taskModel!.title!;
      dueDatecont.text = widget.taskModel!.dueDate!;
      quillcont = QuillController(
          document: Document.fromJson(jsonDecode(widget.taskModel!.discrp)),
          selection: TextSelection.collapsed(offset: 0));
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
      builder: (context, task, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.taskModel != null ? "Update Task" : "Add Task"),
            actions: [
              IconButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    if (widget.taskModel == null) {
                      if (istapped == false) {
                        addData();
                        task.addCategory(category: catcont.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Saved!")));
                        setState(() {
                          istapped = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Already Saved!")));
                      }
                    } else {
                      updateData();
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Saved!")));
                    }
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
                                    Utils.myTextField(label: "Category")),
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
                          const SizedBox(height: 20),
                          DateTimeField(
                            decoration: Utils.myTextField(label: "Due Date"),
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
                            onChanged: (value) {},
                            validator: (value) {
                              if (dueDatecont.text.isEmpty) {
                                return "Select Time";
                              } else
                                return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return "Enter Title";
                              } else
                                return null;
                            },
                            decoration: Utils.myTextField(
                              label: "Title",
                            ),
                            onChanged: (value) {},
                            controller: titlecont,
                          ),
                          const SizedBox(height: 20),
                          QuillEditor(
                            showCursor: true,
                            scrollable: false,
                            expands: false,
                            padding: const EdgeInsets.all(8),
                            scrollController: scrollController,
                            autoFocus: true,
                            focusNode: FocusNode(),
                            controller: quillcont,
                            readOnly: false,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    QuillToolbar.basic(
                      controller: quillcont,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 2,
              ),
              if (widget.taskModel != null)
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 25),
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
        );
      },
    );
  }

  addData() async {
    print("Adding...");
    try {
      TaskModel taskModel = TaskModel(
        editTime: Timestamp.now(),
        userID: FirebaseAuth.instance.currentUser!.uid,
        category: catcont.text,
        title: titlecont.text,
        dueDate: dueDatecont.text,
        discrp: jsonEncode(quillcont.document.toDelta().toJson()),
      );

      await FirebaseFirestore.instance
          .collection("Tasks")
          .add(taskModel.toMap())
          .then((value) async {
        print("Added successfully");
      });

      print("try ended");
    } catch (e) {
      print(e);
    }
  }

  updateData() {
    try {
      widget.taskModel!.category = catcont.text;
      widget.taskModel!.title = titlecont.text;
      widget.taskModel!.dueDate = dueDatecont.text;
      widget.taskModel!.discrp =
          jsonEncode(quillcont.document.toDelta().toJson());
      widget.taskModel!.editTime = Timestamp.now();
      widget.taskModel!.reff!
          .set(widget.taskModel!.toMap())
          .then((value) async {});
    } catch (e) {}
  }
}
