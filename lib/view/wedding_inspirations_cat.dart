// This code displays a list of wedding inspirations based on a specific category

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/model/inspiration_model.dart';
import 'package:wedding_planner/view/wedding_inspirations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WeddingInspirationCat extends StatefulWidget {

  final String category;
  const WeddingInspirationCat({super.key, required this.category});

  @override
  State<WeddingInspirationCat> createState() => _WeddingInspirationCatState();
}

class _WeddingInspirationCatState extends State<WeddingInspirationCat> {

  @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {

    // Fetches real-time data from the "inspiration" collection in the Firestore database.
    final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("inspiration").where("category", isEqualTo: widget.category).snapshots();
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: Text(
            _title(widget.category),
            style: const TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          shape: const Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 218, 218, 218),
              width: 1
            )
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const WeddingInspirations()
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
                  Container(
                    margin: const EdgeInsets.all(20),

                    // Listens to the stream and rebuilds the UI whenever new data is received from the database
                    child:  StreamBuilder<QuerySnapshot> (
                      stream: stream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        } 
                        return MasonryGridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {

                            Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                            InspirationModel inspiration = InspirationModel(
                              id: snapshot.data?.docs[index].id, 
                              image: document["image"],
                              category: document["category"], 
                              theme: document["theme"],
                              color: document["color"]
                            );
                            
                            return Container(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15))
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15)),
                                child: Image(image: AssetImage("images/inspiration/${inspiration.image!}"), fit: BoxFit.cover)
                              ),
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
      ),
    );
  }

  String _title(String category) {
    if (category == "color") {
      return "Wedding Color Palette";
    } else if (category == "decoration") {
      return "Wedding Decoration";
    } else if (category == "attire") {
      return "Wedding Attire";
    } else {
      return "Wedding Flowers";
    } 
      
  }
}