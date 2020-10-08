import 'package:app_test1/widgets/Task_Card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_test1/model/Task.dart';

class TaskStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    User uid = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .doc(uid.uid)
          .collection('tasks')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final tasks = snapshot.data.docs;
        List<TaskCard> taskcards = [];
        for (var task in tasks) {
          final name = task.data()['name'];
          final descrip = task.data()['description'];
          Task taskobject =
              Task(name: name, description: descrip, task_id: task.id);
          taskcards.add(TaskCard(
            task: taskobject,
            onPressed: () {
              Navigator.pushNamed(context, 'task_screen',
                  arguments: taskobject);
            },
          ));
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text("Tap on task to view,edit or delete."),
              backgroundColor: Colors.blue),
          body: ListView(
            children: taskcards,
          ),
        );
      },
    );
  }
}
