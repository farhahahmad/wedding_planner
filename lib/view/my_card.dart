// This code represents a Flutter screen that displays the user's saved invitation cards.

import 'package:flutter/material.dart';
import 'package:wedding_planner/model/card_model.dart';
import 'package:wedding_planner/view/make_invitation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class MyCard extends StatefulWidget {

  const MyCard({Key? key}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  // Fetches real-time data from the "card" collection in the Firestore database.
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("card").snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: const Text(
            "My Invitation Cards",
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
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const MakeInvitation()
              ));
            }
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),

                  // Listens to the stream and rebuilds the UI whenever new data is received from the database
                  child:  StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } 
                      return MasonryGridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                          CardModel card = CardModel(
                            id: snapshot.data?.docs[index].id, 
                            cardImage: document["cardImage"]);
                          return GestureDetector(
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                side: BorderSide(width: 1, color: Color.fromARGB(255, 167, 167, 167))),
                              child: Image(
                                image: NetworkImage(card.cardImage!),
                                fit: BoxFit.cover
                              ),
                            ),
                            onTap: () async {
                              // user can share the card image through different platforms
                              final response = await http.get(Uri.parse(card.cardImage!));
                              final bytes = response.bodyBytes;
                              final directory = await Directory.systemTemp.create();
                              final filePath = '${directory.path}/file.png';
                              File file = await File(filePath).writeAsBytes(bytes);
                              XFile newFile = XFile(file.path);
                              await Share.shareXFiles([newFile], text: 'We would be honored to have you join us in celebrating our special day.');
                            },
                          );
                        },
                      );
                    }
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