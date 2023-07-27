// This code allows users to customize their wedding color palette and select a wedding theme 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/palette_collections.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wedding_planner/view/wedding_inspirations.dart';

class CustomizeInspirations extends StatefulWidget {
  const CustomizeInspirations({Key? key}) : super(key: key);

  @override
  State<CustomizeInspirations> createState() => _CustomizeInspirationsState();
}

class _CustomizeInspirationsState extends State<CustomizeInspirations> {

  String measure = "";
  String color1 = "#FF9E9E9E";
  String color2 = "#FF607D8B";
  String color3 = "#FF00BCD4";

  // This method is called when a user picks a color from the color picker dialog.
  void changeColor(String colorString, String colorType) {
    if (colorType == "color1") {
      setState(() => color1 = colorString);
    }
    else if (colorType == "color2") {
      setState(() => color2 = colorString);
    }
    else {
      setState(() => color3 = colorString);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Wedding Color Palette",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  )
                ),
              ),
              const SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                children: [
                  _colorItem(color1, "color1"),
                  _colorItem(color2, "color2"),
                  _colorItem(color3, "color3")
                ],
              ),
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Wedding Theme",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  )
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                      borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(
                    value: "garden",
                    child: Text("Garden", style: TextStyle(fontSize: 15)),
                  ),
                  DropdownMenuItem(
                    value: "malay",
                    child: Text("Classic Malay", style: TextStyle(fontSize: 15)),
                  ),
                  DropdownMenuItem(
                    value: "glam",
                    child: Text("Glamorous", style: TextStyle(fontSize: 15)),
                  ),
                ],
                hint: const Text("Select item", style: TextStyle(fontSize: 15)),
                onChanged: (value) {
                  setState(() {
                    measure = value!;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    measure = value!;
                  });
                }
              ),
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 80,
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            minimumSize: const Size.fromHeight(50),
            backgroundColor: HexColor("#C0ABAF")
          ),
          child: const Text('Save Palette & Theme', style: TextStyle(fontSize: 15),),
          onPressed: () {

            // Adds the user input to the 'palette' collection in database
            FirebaseFirestore.instance.collection("palette").add({
              "color1" : color1, "color2" : color2, "color3" : color3, "theme": measure
            });

            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const PaletteCollections()
            ));
          },
        )
      ),
    );
  }

  // This method displays a color tile with a color picker icon
  Container _colorItem(String colorString, String colorType) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: HexColor(colorString),
        title: Text(
          colorString,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
        trailing: IconButton(
          color: Colors.black,
          iconSize: 18,
          icon: const Icon(Icons.colorize),
          onPressed: () {
            showDialog(
              context: context, 
              builder: ((context) => AlertDialog(
                title: const Text("Pick a color!", style: TextStyle(fontSize: 15)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlockPicker(
                      pickerColor: HexColor(colorString),
                      onColorChanged: (Color color){ 
                        changeColor(colorToHex(color), colorType);
                      }, 
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: const Text("Done", style: TextStyle(fontSize: 15))
                  )
                ],
              ))
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Choose preferred inspirations",
        style: TextStyle(
          color: Colors.black,
          fontSize: 15
        ),
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
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const PaletteCollections()
            ));
          }, 
          icon: Icon(Icons.palette, color: HexColor("#C0ABAF"),)
        )
      ],
    );
  }
}