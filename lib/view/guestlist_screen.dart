// This code represents a Guestlist Screen where users can manage a list of guests. 

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/controller/list_controller.dart';
import 'package:wedding_planner/model/card_model.dart';
import 'package:wedding_planner/view/planner_screen.dart';
import 'package:wedding_planner/widgets/guest_item.dart';
import '../model/guest_model.dart';

class GuestlistScreen extends StatefulWidget {
  const GuestlistScreen({Key? key}) : super(key: key);

  @override
  State<GuestlistScreen> createState() => _GuestlistScreenState();
}

class _GuestlistScreenState extends State<GuestlistScreen> {

  // Fetches real-time data from the "guest" collection in the Firestore database.
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("guest").snapshots();
  final ListController _con = ListController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  late CardModel card = CardModel(id: "", cardImage: "");

  @override
  void initState() {
    super.initState();

    final Query query = FirebaseFirestore.instance.collection('card').limit(1);

    query.get().then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
        card = CardModel(
          id: documentSnapshot.id, 
          cardImage: documentSnapshot["cardImage"]
        );

      } else {
        print('Document does not exist');
      }

    }).catchError((error) {
      print('Error getting document: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F3EBEC"),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            margin: const EdgeInsets.only(bottom: 50),
            child: Column(
              children: [
                Expanded(

                  // Listens to the stream and rebuilds the UI whenever new data is received from the database
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } 
                      return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                          GuestModel currentGuest = GuestModel(id: snapshot.data?.docs[index].id, name: document["name"], address: document["address"], isDone: document["isDone"]);
                          return GuestItem(
                            guest:  currentGuest, 
                            card: card,
                            onToDoChanged: _con.updateGuest, 
                            onDeleteItem: _con.deleteGuest
                          );
                        } 
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) => AlertDialog(
                      title: const Text("Add a new guest", style: TextStyle(fontSize: 15)),
                      content: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(hintText: "Name")
                            ),
                            TextField(
                              controller: _addressController,
                              decoration: const InputDecoration(hintText: "Address")
                            ),
                          ]
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: (){
                            // The guest information is sent to the controller to be added to the database
                            _con.addGuest(_nameController.text, _addressController.text);
                            _nameController.clear();
                            _addressController.clear();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Add", style: TextStyle(fontSize: 15))
                        )
                      ],
                    )
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#C0ABAF"),
                  minimumSize: const Size(50, 50),
                  elevation: 10,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    Text("Add a new guest ", style: TextStyle(fontSize: 15)),
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
      "Guest List",
      style: TextStyle(color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: HexColor("#F3EBEC"),
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
    );
  }
}