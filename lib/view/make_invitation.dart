// This code allows users to make wedding invitation cards. 

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/invitation_card.dart';
import 'package:wedding_planner/view/my_card.dart';
import 'package:wedding_planner/view/planner_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MakeInvitation extends StatefulWidget {

  const MakeInvitation({Key? key}) : super(key: key);

  @override
  State<MakeInvitation> createState() => _MakeInvitationState();
}

class _MakeInvitationState extends State<MakeInvitation> {

  final List<String> imagePaths = [
    'card1.png',
    'card2.png',
    'card3.png',
    'card4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: const Text(
            "Invitation Card Maker",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          shape: const Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 218, 218, 218),
              width: 1
            )
          ),
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const PlannerScreen()
              ));
            }
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MyCard()
                ));
              }, 
              icon: Icon(Icons.mark_email_read, color: HexColor("#C0ABAF"),)
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child:  MasonryGridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      // Card templates that users can choose from to customize their wedding invitation card
                      return GestureDetector(
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(width: 1, color: Color.fromARGB(255, 167, 167, 167))),
                          child: Image(image: AssetImage("images/${imagePaths[index]}"), fit: BoxFit.cover),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => InvitationCard(imagePath: imagePaths[index])
                          ));
                        },
                      );
                    },
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}