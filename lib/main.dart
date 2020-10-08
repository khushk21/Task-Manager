import 'package:app_test1/screens/log_in.dart';
import 'package:app_test1/screens/sign_up.dart';
import 'package:app_test1/screens/taskpage.dart';
import 'package:app_test1/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/task_screen.dart';
import 'widgets/ts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TaskManager());
}

class TaskManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black54))),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => WelcomeScreen(),
        'sign_up': (context) => SignUp(),
        'log_in': (context) => LogIn(),
        'taskpage': (context) => TaskPage(),
        'ts': (context) => TaskStream(),
        'task_screen': (context) => TaskScreen()
      },
    );
  }
}
