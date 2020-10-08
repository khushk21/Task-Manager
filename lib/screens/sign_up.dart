import 'package:flutter/material.dart';
import 'package:app_test1/widgets/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_test1/constants/constants.dart';
import 'package:app_test1/screens/taskpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Registration Page"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter your email"),
                ),
                SizedBox(height: 8.0),
                TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter your password"),
                ),
                SizedBox(height: 24.0),
                RoundedButton(
                    title: "Sign Up",
                    colour: Colors.blue,
                    onPressed: () async {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          final uid = newUser.user.uid;
                          _firestore
                              .collection('users')
                              .doc(uid)
                              .set({'email': email});
                          Navigator.pushNamed(context, 'taskpage');
                        }
                      } catch (e) {
                        print(e);
                      }
                    })
              ],
            )));
  }
}
