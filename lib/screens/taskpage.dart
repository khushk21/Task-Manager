import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_test1/constants/constants.dart';
import 'package:app_test1/widgets/roundedbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _auth = FirebaseAuth.instance;
  String task_id;
  String task_name;
  String task_descrip;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text("Task Page"),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                child: Text("Sign Out",
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                },
              )
            ]),
        body: Form(
            key: _formkey,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        task_name = value;
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter task name"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter task name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        task_descrip = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter task description"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter task description";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    RoundedButton(
                        colour: Colors.blue,
                        title: "Enter Task",
                        onPressed: () {
                          _firestore
                              .collection('users')
                              .doc(loggedInUser.uid)
                              .collection('tasks')
                              .doc(task_name)
                              .set({
                            'name': task_name,
                            'description': task_descrip,
                          });
                        }),
                    RoundedButton(
                        colour: Colors.blue,
                        title: "View Tasks",
                        onPressed: () {
                          Navigator.pushNamed(context, 'ts');
                        })
                  ],
                ))));
  }
}
