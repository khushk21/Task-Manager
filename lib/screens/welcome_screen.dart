import 'package:flutter/material.dart';
import 'package:app_test1/widgets/roundedbutton.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("TaskManager"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RoundedButton(
                    title: 'Sign Up',
                    colour: Colors.blue,
                    onPressed: () {
                      Navigator.pushNamed(context, 'sign_up');
                    }),
                RoundedButton(
                    title: 'Log In',
                    colour: Colors.blue,
                    onPressed: () {
                      Navigator.pushNamed(context, 'log_in');
                    })
              ],
            )));
  }
}
