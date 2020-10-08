import 'package:flutter/material.dart';
import 'package:app_test1/model/Task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_test1/constants/constants.dart';

class TaskScreen extends StatefulWidget {
  Task task;
  TaskScreen({this.task});
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  String name = '';
  String descript = '';
  String task_id = '';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Task task;
  TextEditingController name_control;
  TextEditingController descript_control;

  @override
  void initstate() {
    print(ModalRoute.of(context).settings.arguments);
    super.initState();
    if (task != null) {
      name = task.name;
      descript = task.description;
    }
  }

  Widget build(BuildContext context) {
    Task taskobject = ModalRoute.of(context).settings.arguments;
    task_id = taskobject.task_id;
    name_control = TextEditingController(text: taskobject.name);
    descript_control = TextEditingController(text: taskobject.description);
    User user = _auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Edit/Delete Task"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
              onPressed: () {
                saved();
                Navigator.pop(context);
              }),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                //print(new_id);
                _firestore
                    .collection('users')
                    .doc(user.uid)
                    .collection('tasks')
                    .doc(task_id)
                    .delete();
                Navigator.pop(context);
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: kSmallMargin),
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: name_control,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: "Task Name"),
              onChanged: (value) {
                name = value;
              },
            ),
          ),
          SizedBox(height: 12.0),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(kLargeMargin),
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: descript_control,
                    textAlign: TextAlign.center,
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: "Task Description"),
                    onChanged: (value) {
                      descript = value;
                    },
                  )))
        ],
      ),
    );
  }

  void saved() {
    User user = _auth.currentUser;
    _firestore
        .collection('users')
        .doc(user.uid)
        .collection('tasks')
        .doc(task_id)
        .update({'name': name, 'description': descript});
  }
}
