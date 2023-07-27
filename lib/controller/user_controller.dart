// This code defines a Flutter controller class which handles user authentication functionality allowing users to sign up and sign in

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_planner/model/user_model.dart';
import 'package:wedding_planner/view/admin_home.dart';
import 'package:wedding_planner/view/home_screen.dart';

class UserController extends ControllerMVC {

  factory UserController() {
    _this ??= UserController._();
    return _this!;
  }
  static UserController? _this;

  UserController._();
  final _auth = FirebaseAuth.instance;
  String? errorMessage;

  // Handles user registration by creating a new user account using Firebase Authentication
  void signUp(bool formState, String email, String password, String username, BuildContext context) async {
    if (formState) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {signUpToFirestore(username, context)})
            .catchError((e) => {
          Fluttertoast.showToast(msg: e!.message)
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  // Saves the user's information to the Firestore database
  void signUpToFirestore(String username, BuildContext context) async {

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.userName = username;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false);
  }

  // Handles user login by signs in the user using Firebase Authentication
  void signIn(bool formState, String email, String password, BuildContext context) async {
    if (formState) {
      if (email == "admin@gmail.com" && password == "123456") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const AdminHome()));
      } else {
        try {
          SharedPreferences prefs;
          String isSupplier = "false";
          await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) async => {

              FirebaseFirestore.instance.collection('users').doc(uid.user!.uid)
              .get().then((DocumentSnapshot documentSnapshot) async {
                if (documentSnapshot.exists) {
                  isSupplier = documentSnapshot["supplier"].toString();
                  prefs = await SharedPreferences.getInstance();
                  prefs.setString('userid', uid.user!.uid);
                  prefs.setString('isSupplier', isSupplier);
                } else {
                  print('Document does not exist on the database');
                }
              }),
              
              Fluttertoast.showToast(msg: "Login Successful"),
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomeScreen())),
              });
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case "invalid-email":
              errorMessage = "Your email address appears to be malformed.";

              break;
            case "wrong-password":
              errorMessage = "Your password is wrong.";
              break;
            case "user-not-found":
              errorMessage = "User with this email doesn't exist.";
              break;
            case "user-disabled":
              errorMessage = "User with this email has been disabled.";
              break;
            case "too-many-requests":
              errorMessage = "Too many requests";
              break;
            case "operation-not-allowed":
              errorMessage = "Signing in with Email and Password is not enabled.";
              break;
            default:
              errorMessage = "An undefined Error happened.";
          }
          Fluttertoast.showToast(msg: errorMessage!);
          print(error.code);
        } 
      }
    }
  }
}