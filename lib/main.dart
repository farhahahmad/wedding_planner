import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_planner/view/home_screen.dart';
import 'package:wedding_planner/view/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs =await SharedPreferences.getInstance();
  var userid = prefs.getString("userid");

  runApp(MyApp(userid: userid));
}

class MyApp extends StatelessWidget {
  var userid;
  MyApp({super.key, required this.userid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userid == null? LoginScreen(): HomeScreen()
      // home: LoginScreen(),
    );
  }
}


