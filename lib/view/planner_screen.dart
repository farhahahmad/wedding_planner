// This code represents a screen for wedding planning tools

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/checklist_screen.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/guestlist_screen.dart';
import 'package:wedding_planner/view/make_invitation.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

   
  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        key: _key,
        drawer: const DrawerUser(),
        appBar: AppBar(
         title: const Text(
            "Planning Tools",
            style: TextStyle(color: Colors.black, fontSize: 17),
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
                    builder: (context) => const ChecklistScreen()
                  ));
                },
                child: _inspoItem(item[0]),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const GuestlistScreen()
                  ));
                },
                child: _inspoItem(item[1]),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const MakeInvitation()
                  ));
                },
                child: _inspoItem(item[2]),
              )
            ],
        )
      )
    );
   }

  // This method creates a container for each planning tool 
  Container _inspoItem(Item item) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: HexColor(item.colorString)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            item.icon, 
            size: 50,
            color: Colors.black,
          ),
          const SizedBox(height: 15),
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Colors.black,
              height: 1.5)
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
  
// A list item is created representing the three planning tools
List<Item> item = const <Item>[  
  Item(
    title: "Checklist", 
    icon: Icons.description,
    colorString: "#D8CDBC"),
  Item(
    title: "Guest List", 
    icon: Icons.people_alt_outlined,
    colorString: "#CEAAAA"),
  Item(
    title: "Invitation Card Maker", 
    icon: Icons.forward_to_inbox,
    colorString: "#CBB6BA"),
];  