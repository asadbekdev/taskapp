import 'package:exam/models/db_helper.dart';
import 'package:exam/models/task.dart';
import 'package:exam/screens/home/components/task_item.dart';
import 'package:exam/screens/tasks/components/avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper = DatabaseHelper();
  var taskTitle, taskSubTitle, taskTime;
  static DatabaseHelper? dbTasks;
  static List<TaskClass>? taskList;

  @override
  void initState() {
    taskList = <TaskClass>[];
    dbTasks = DatabaseHelper();
    dbTasks!.fetchDatas().then((allTasksList) {
      for (var readStudent in allTasksList) {
        taskList!.add(TaskClass.fromMap(readStudent));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tasks",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: kDefaultPadding),
            child: ImageIcon(AssetImage("assets/icons/Calendar.png")),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: kPrimaryColor,
      body: body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: kPrimaryColor,
        ),
        backgroundColor: kBackgroundColor,
        elevation: 2.0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: kPrimaryColor,
                title: Text(
                  "Add task",
                  style: TextStyle(color: Colors.white),
                ),
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "Task title",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF5F5F5),
                              hintText: "Enter task name...",
                              hintStyle: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 13.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding,
                                  vertical: kDefaultPadding / 1.4),
                            ),
                            validator: (kiritilganInput) {
                              if (kiritilganInput!.length < 4) {
                                return "Enter at least 4 letter";
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                taskTitle = value;
                              });
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "Task subtitle",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF5F5F5),
                              hintText: "Enter task subtitle...",
                              hintStyle: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 13.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding,
                                  vertical: kDefaultPadding / 1.4),
                            ),
                            validator: (kiritilganInput) {
                              if (kiritilganInput!.length < 4) {
                                return "Enter at least 4 letter";
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                taskSubTitle = value;
                              });
                            },
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "Task time",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF5F5F5),
                              hintText: "Enter task time...",
                              hintStyle: TextStyle(
                                color: kSecondaryColor,
                                fontSize: 13.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: kDefaultPadding,
                                  vertical: kDefaultPadding / 1.4),
                            ),
                            validator: (kiritilganInput) {
                              if (kiritilganInput!.isEmpty) {
                                return "Field can't be empty";
                              }
                            },
                            onSaved: (value) {
                              setState(() {
                                taskTime = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonBar(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.greenAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text("Send"),
                        onPressed: _addData,
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _addData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await databaseHelper
          .taskAdd(TaskClass(taskTitle, taskSubTitle, taskTime))
          .then((tId) {
        taskList!.clear();
        dbTasks!.fetchDatas().then((allKategoriyasList) {
          setState(() {
            for (var readKategoriya in allKategoriyasList) {
              taskList!.add(TaskClass.fromMap(readKategoriya));
            }
          });
        });
      });
    }
    Navigator.of(context).pop();
  }

  body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: FutureBuilder(
        future: dbTasks!.fetchDatas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: taskList!.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  child: TaskItem(
                    title: "${taskList![index].taskTitle}",
                    subtitle: "${taskList![index].taskSubtitle}",
                    users: [Avatar(img: "assets/images/myPic.jpg", radius: 15)],
                    time: "${taskList![index].taskTime}",
                  ),
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
