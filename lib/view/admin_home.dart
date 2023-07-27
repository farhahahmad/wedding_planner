// This code  represents the home screen for the admin in the system

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/admin_drawer.dart';
import 'package:wedding_planner/view/admin_procedure.dart';
import 'package:wedding_planner/view/approve_supplier.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

   
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: HexColor("#EDE9ED"),
        key: _key,
        drawer: const AdminDrawer(),
        appBar: AppBar(
         title: const Text(
            "Home",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: HexColor("#EDE9ED"),
          leading: IconButton(  // Menu icon that opens the admin drawer menu
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _key.currentState?.openDrawer();
            }
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            crossAxisCount: 2,  
            crossAxisSpacing: 15,  
            mainAxisSpacing: 15,  
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const AdminProcedure()
                  ));
                },
                child: _container(item[0]),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const ApproveSupplier()
                  ));
                },
                child: _container(item[1]),
              )
            ],
        )
      )
    );
   }

  // Represents option that navigate admin to the corresponding screen
  Container _container(Item item) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.withOpacity(0.2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 50, color: HexColor("#605560")),
          const SizedBox(height: 15),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              color: HexColor("#605560")
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
   }
}

class Item {  
  const Item({required this.title, required this.icon, required this.colorString});  
  final String title;  
  final IconData icon;
  final String colorString;
}  
  
List<Item> item = const <Item>[  
  Item(
    title: "Update Marriage Procedure", 
    icon: Icons.description,
    colorString: "#D8CDBC"),
  Item(
    title: "Approve Supplier", 
    icon: Icons.people_alt_outlined,
    colorString: "#D8CDBC"),
];  