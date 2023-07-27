// This code displays a list of vendor categories

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/vendors_category.dart';

class VendorsScreen extends StatefulWidget {
  const VendorsScreen({super.key});

   
  @override
  State<VendorsScreen> createState() => _VendorsScreenState();
}

class _VendorsScreenState extends State<VendorsScreen> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        key: _key,
        drawer: const DrawerUser(),
        appBar: AppBar(
         title: const Text(
            "Vendors",
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                _vendorItem(context, "#CEAAAA", "Venues", "Banquet hall, garden, villa", "images/vendors_venue.png", "venues"),
                const SizedBox(height: 25),
                _vendorItem(context, "#D8CDBC", "Catering", "Food, cake, food stalls", "images/vendors_catering.png", "catering"),
                const SizedBox(height: 25),
                _vendorItem(context, "#CBB6BA", "Bridal wear", "Bridal dresses, accessories", "images/vendors_bridal.png", "bridal"),
                const SizedBox(height: 25),
                _vendorItem(context, "#CDBCCF", "Photographer", "Photographers, video", "images/vendors_photographer.png", "photographer"),
                const SizedBox(height: 25),
                _vendorItem(context, "#DEB0B8", "Makeup", "Bridal makeup, family makeup", "images/vendors_makeup.png", "makeup"),
              ]
            )
          )
        )
      );
    }

  // Displays the necessary information for each vendor category and navigates to the VendorsCategory screen
  GestureDetector _vendorItem(BuildContext context, String colorC, String title, String subtitle, String image, String category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => VendorsCategory(category: category)
        ));
      },
      child: Container(
        color: HexColor(colorC),
        height: 90,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20,0,0,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    )
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 15)
                  ),
                ],
              ),
            ),
            Image(image: AssetImage(image))
          ],
        )
      ),
    );
   }
}