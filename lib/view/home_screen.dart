import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/checklist_screen.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/marriage_procedure_menu.dart';
import 'package:wedding_planner/view/vendors_category.dart';
import 'package:wedding_planner/view/wedding_inspirations_cat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

   
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor("#FFFBFF"),
      key: _key,
      drawer: const DrawerUser(),
      appBar: AppBar(
        title: const Text(
        "Home",
        style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: HexColor("#FFFBFF"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(image: AssetImage("images/supplier_bg.png")),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Wedding Planning Tools",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          child: _planningItem("Build checklist", const Icon(Icons.description, color: Colors.white)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const ChecklistScreen()));
                          },
                        ),
                        const SizedBox(width: 20),        
                        GestureDetector(
                          child: _planningItem("Manage guest list", const Icon(Icons.people_alt_outlined, color: Colors.white)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const ChecklistScreen()));
                          },
                        ),       
                        const SizedBox(width: 20),  
                        GestureDetector(
                          child: _planningItem("Make invitation card", const Icon(Icons.forward_to_inbox_outlined, color: Colors.white)),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const ChecklistScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Wedding Vendors",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: Colors.black,
                      fontSize: 15
                    )
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _vendorsItem("images/home_venue.jpg", "Venues", "venues"),
                        const SizedBox(width: 15),
                        _vendorsItem("images/vendors_catering.png", "Catering", "catering"),
                        const SizedBox(width: 15),
                        _vendorsItem("images/home_bridal.jpg", "Bridal wear", "bridal"),
                        const SizedBox(width: 15),
                        _vendorsItem("images/vendors_photographer.png", "Photographer", "photographer"),
                        const SizedBox(width: 15),
                        _vendorsItem("images/vendors_makeup.png", "Makeup", "makeup"),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Marriage Procedure",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: HexColor("#CBB6BA")
                      ),
                      child: const Row(
                        children: [
                          Expanded(child: Text(
                            'Check marriage application process',
                            style: TextStyle(fontSize: 15),
                          )),
                          Icon(Icons.arrow_forward_ios, color: Colors.white)
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const MarriageProcedureMenu()
                        ));
                      },
                    )
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "Wedding Inspirations",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: Colors.black,
                      fontSize: 15
                    )
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const WeddingInspirationCat(category: "color")
                            ));
                          },
                          child: _inspoItem("Color", "images/home_color.png")
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const WeddingInspirationCat(category: "decoration")
                            ));
                          },
                          child: _inspoItem("Decoration", "images/wedding.png")
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const WeddingInspirationCat(category: "attire")
                            ));
                          },
                          child: _inspoItem("Attire", "images/home_attire.jpg")
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const WeddingInspirationCat(category: "flower")
                            ));
                          },
                          child: _inspoItem("Flowers", "images/inspo_flower.png")
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  GestureDetector _vendorsItem(String image, String title, String category) {
    return GestureDetector(
      child: Column(
        children: [
          CircleAvatar(
            maxRadius: 40,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => VendorsCategory(category: category)));
      },
    );
   }

  Container _planningItem(String title, Icon icon) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: HexColor("#C0ABAF"),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title, 
            style: const TextStyle( 
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15
            )
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: icon
          )
        ],
      ),
    );
   }

  SizedBox _inspoItem(String title, String imageString) {
    return SizedBox(
      height: 115,
      width: 110,
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15)
              ),
              child: Image(
                image: AssetImage(imageString),
                fit: BoxFit.cover,
              ),
            )
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)
              ),
              color: HexColor("#C0ABAF"),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title, 
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              )
            ),
          )
        ],
      ),
    );
  }
}
