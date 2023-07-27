// This code represents the screen where the admin can view and update the different steps of the marriage procedure

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/admin_home.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/update_procedure.dart';

class AdminProcedure extends StatefulWidget {
  const AdminProcedure({super.key});

  @override
  State<AdminProcedure> createState() => _AdminProcedureState();
}

class _AdminProcedureState extends State<AdminProcedure> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        key: _key,
        drawer: const DrawerUser(),
        appBar: AppBar(
         title: const Text(
          "Marriage Procedure",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17
          ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const AdminHome()
              ));
            }
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _procedureItem(context, 'Marriage Application Procedure', 'application'),
                  _procedureItem(context, 'Required Document', 'requiredDoc'),
                  _procedureItem(context, 'Pre-marriage Course', 'maritalCourse'),
                  _procedureItem(context, 'Online Marriage Application Form', 'appForm'),
                ],
              ),
            ),
          )
        ),
      );
   }

  // Procedure items that navigates to the UpdateProcedure screen
  Container _procedureItem(BuildContext context, String title, String docName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20,10,20,10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size.fromHeight(50),
          backgroundColor: HexColor("#605560")
        ),
        child: Row(
          children : [
            Expanded(
              child: Text(
                title, 
                style: const TextStyle(fontSize: 15)
              ),
            ),
            const Icon(Icons.edit, color: Colors.white)
          ]
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => UpdateProcedure(title: title, docName: docName)
          ));
        },
      )
    );
   }
}