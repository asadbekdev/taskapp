// import 'package:exam/constants.dart';
// import 'package:exam/models/db_helper.dart';
// import 'package:exam/models/task.dart';
// import 'package:exam/screens/tasks/components/avatar.dart';
// import 'package:exam/screens/tasks/components/task_item.dart';
// import 'package:flutter/material.dart';

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   DatabaseHelper databaseHelper = DatabaseHelper();
//   DatabaseHelper? dbTasks;
//   List<TaskClass>? taskList;
//   var formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     taskList = <TaskClass>[];
//     dbTasks = DatabaseHelper();
//     dbTasks!.fetchDatas().then((allTasksList) {
//       for (var readStudent in allTasksList) {
//         taskList!.add(TaskClass.fromMap(readStudent));
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//       child: FutureBuilder(
//         future: dbTasks!.fetchDatas(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               physics: BouncingScrollPhysics(),
//               itemCount: taskList!.length,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin:
//                       EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
//                   child: TaskItem(
//                     title: "${taskList![index].taskTitle}",
//                     subtitle: "${taskList![index].taskSubtitle}",
//                     users: [
//                       Avatar(img: "assets/images/myPic.jpg", radius: 15)
//                     ],
//                     time: "${taskList![index].taskTime}",
//                   ),
//                 );
//               },
//             );
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }

  
// }
