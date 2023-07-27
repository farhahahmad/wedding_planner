// This code is designed to match color palettes with inspirations from a Firestore database. 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wedding_planner/model/inspiration_model.dart';
import 'package:wedding_planner/model/palette_model.dart';
import 'package:wedding_planner/view/palette_collections.dart';
import 'package:hexcolor/hexcolor.dart';

class ColorPaletteMatcher extends StatefulWidget {

  final PaletteModel palette;
  const ColorPaletteMatcher({super.key, required this.palette});
   
  @override
  State<ColorPaletteMatcher> createState() => _ColorPaletteMatcherState();
}

class _ColorPaletteMatcherState extends State<ColorPaletteMatcher> {

  late final Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();

    // Fetches real-time data from the "inspiration" collection in the Firestore database.
    _stream = FirebaseFirestore.instance.collection("inspiration")
    .where("theme", isEqualTo: widget.palette.theme)
    .where((Filter.or(
      Filter("color", isEqualTo: widget.palette.color1),
      Filter("color", isEqualTo: widget.palette.color2),
      Filter("color", isEqualTo: widget.palette.color3),
    )))
    .snapshots();
  }

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 220, 220, 220),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Theme : ${_themeTitle(widget.palette.theme!)}", 
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        )
                      ),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                color: HexColor(widget.palette.color1!),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: HexColor(widget.palette.color2!),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: HexColor(widget.palette.color3!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  child:  
                  // Listens to the stream and rebuilds the UI whenever new data is received from the database
                  StreamBuilder<QuerySnapshot> (
                    stream: _stream,
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
              ]
            ),
          ),
        )
      );
   }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Collections",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15
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
            builder: (context) => const PaletteCollections()
          ));
        }
      ),
    );
  }

  String _themeTitle(String theme) {
    if (theme == "malay") {
      return "Classic Malay";
    } else if (theme == "glam") {
      return "Glamorous";
    } else {
      return "Garden";
    }
  }
}