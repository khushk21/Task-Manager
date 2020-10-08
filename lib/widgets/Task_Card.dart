import 'package:flutter/material.dart';
import 'package:app_test1/constants/constants.dart';
import 'package:app_test1/model/Task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function onPressed;
  TaskCard({this.task, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.blue,
        margin: EdgeInsets.symmetric(
            horizontal: kLargeMargin, vertical: kSmallMargin),
        child: ListTile(
          title: Text(task.name),
          subtitle: Text(task.description),
        ),
      ),
    );
  }
}
