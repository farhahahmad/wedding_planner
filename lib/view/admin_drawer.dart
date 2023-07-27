// This code displays a drawer menu for the admin user, allowing them to navigate to the admin home screen and log out from the app. 

import 'package:flutter/material.dart';
import 'package:wedding_planner/view/admin_home.dart';
import 'package:wedding_planner/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userid = "";

class AdminDrawer extends StatefulWidget {
  const AdminDrawer ({super.key});

   
  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {

  @override
  void initState() {
    super.initState();
    _loadUser();
  }


  // Retrieves the user ID from SharedPreferences
  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('userid')??'');
    });
  }

   @override
    Widget build(BuildContext context) {

      return Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const AdminHome()
                ));
              },
              leading: const Icon(Icons.home),
              title: const Text("Home", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () async {
                // remove the user ID from SharedPreferences
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("userid");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const LoginScreen()
                ));
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout", style: TextStyle(fontSize: 15)),
            ),
            const ListTile(),
          ],
        ),
      );
   }
}