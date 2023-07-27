// This code displays a collection of color palettes created by user.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/palette_model.dart';
import 'package:wedding_planner/view/customize_inspirations.dart';
import 'package:wedding_planner/view/image_palette.dart';

class PaletteCollections extends StatefulWidget {
  const PaletteCollections({Key? key}) : super(key: key);

  @override
  State<PaletteCollections> createState() => _PaletteCollectionsState();
}

class _PaletteCollectionsState extends State<PaletteCollections> {

  // Fetches real-time data from the "palette" collection in the Firestore database.
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("palette").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
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
                      PaletteModel palette = PaletteModel(
                        id: snapshot.data?.docs[index].id, 
                        color1: document["color1"],
                        color2: document["color2"],
                        color3: document["color3"],
                        theme: document["theme"]);
                      return _colorItem(palette);
                    } 
                  );
                },
              ),
            )
          ],
        ),
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

  GestureDetector _colorItem(PaletteModel palette) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ColorPaletteMatcher(palette: palette)
        ));
      },
      child: Container(
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
              "Theme : " + _themeTitle(palette.theme!), 
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
                      color: HexColor(palette.color1!),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: HexColor(palette.color2!),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: HexColor(palette.color3!),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
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
            builder: (context) => const CustomizeInspirations()
          ));
        }
      ),
    );
  }
}