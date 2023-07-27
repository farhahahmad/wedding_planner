// This code displays wedding inspirations categories

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/customize_inspirations.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/wedding_inspirations_cat.dart';

class WeddingInspirations extends StatefulWidget {
  const WeddingInspirations({super.key});

   
  @override
  State<WeddingInspirations> createState() => _WeddingInspirationsState();
}

class _WeddingInspirationsState extends State<WeddingInspirations> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        key: _key,
        drawer: const DrawerUser(),
        appBar: AppBar(
         title: const Text(
            "Wedding Inspirations",
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
          elevation: 0.0,
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
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,  
                  crossAxisSpacing: 15,  
                  mainAxisSpacing: 15,  
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const WeddingInspirationCat(category: "color")
                        ));
                      },
                      child: _inspoItem(item[0]),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const WeddingInspirationCat(category: "decoration")
                        ));
                      },
                      child: _inspoItem(item[1]),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const WeddingInspirationCat(category: "attire")
                        ));
                      },
                      child: _inspoItem(item[2]),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const WeddingInspirationCat(category: "flower")
                        ));
                      },
                      child: _inspoItem(item[3]),
                    )
                  ],
                      ),
              ),

              Container(
                height: 80,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: HexColor("#C0ABAF")
                  ),
                  child: const Row(
                    children: [
                      Expanded(child: Text('Customize Wedding Inspirations', style: TextStyle(fontSize: 15))),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>  const CustomizeInspirations()
                    ));
                  },
                )
              ),
            ],
          )
      )
    );
   }

  // Creates the UI layout for each wedding inspiration category item
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
          Image(
            image: AssetImage(item.imageString),
            height: 50, 
            width: 50,
          ),
          const SizedBox(height: 15),
          Text(
            item.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          )
        ],
      ),
    );
   }
}

class Item {  
  const Item({required this.title, required this.imageString, required this.colorString});  
  final String title;  
  final String imageString;
  final String colorString;
}  
  
// A list of Item objects is created, representing the different wedding inspiration categories
List<Item> item = const <Item>[  
  Item(
    title: "Wedding Color Palette", 
    imageString: "images/wedding_color_palette.png", 
    colorString: "#D8CDBC"),
  Item(
    title: "Wedding Decoration", 
    imageString: "images/wedding_deco.png", 
    colorString: "#CEAAAA"),
  Item(
    title: "Wedding Attire", 
    imageString: "images/wedding_themes.png", 
    colorString: "#CBB6BA"),
  Item(
    title: "Wedding Flowers", 
    imageString: "images/wedding_flowers.png", 
    colorString: "#CDBCCF"),
];  