// This code allows user to select different options to learn more about various procedures related to marriage. 

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/chatbot_screen.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/procedure_details.dart';

class MarriageProcedureMenu extends StatefulWidget {
  const MarriageProcedureMenu({super.key});

   
  @override
  State<MarriageProcedureMenu> createState() => _MarriageProcedureMenuState();
}

class _MarriageProcedureMenuState extends State<MarriageProcedureMenu> {

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
          shape: const Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 218, 218, 218),
              width: 1
            )
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _key.currentState?.openDrawer();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: HexColor("#C0ABAF"),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
            builder: (context) => const ChatbotScreen()
          ));
          },
          child: const Icon(Icons.chat),
      ),
      );
   }

    // This function generates a button for each procedure that navigates to the ProcedureDetails screen
    Container _procedureItem(BuildContext context, String title, String docName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20,10,20,10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size.fromHeight(50),
          backgroundColor: HexColor("#C0ABAF")
        ),
        child: Text(
          title, 
          style: const TextStyle(fontSize: 15)
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ProcedureDetails(title: title, docName: docName)
          ));
        },
      )
    );
   }
}