// This code displays a list of vendors based on a specific category

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/model/vendors_model.dart';
import 'package:wedding_planner/view/vendors_details.dart';
import 'package:wedding_planner/view/vendors_screen.dart';

class VendorsCategory extends StatefulWidget {
  
  final String category;
  const VendorsCategory({super.key, required this.category});

  @override
  State<VendorsCategory> createState() => _VendorsCategoryState();
}

class _VendorsCategoryState extends State<VendorsCategory> {

  @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {

    // Fetches real-time data from the "vendors" collection in the Firestore database.
    final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("vendors").where("category", isEqualTo: widget.category).snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),

        // Listens to the stream and rebuilds the UI whenever new data is received from the database
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } 
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                VendorsModel vendors = VendorsModel(
                  id: snapshot.data?.docs[index].id, 
                  name: document["name"], 
                  description: document["description"], 
                  price: document["price"].toDouble(), 
                  location: document["location"], 
                  category: document["category"], 
                  image: document["image"], 
                  email: document["email"],
                  phone: document["phone"]
                );
                return _venueItem(vendors);
              } 
            );
          },
        ),
      ),
    );
  }

  GestureDetector _venueItem(VendorsModel vendors) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => VendorsDetails(vendors: vendors)
        ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: NetworkImage(vendors.image!),
                  fit: BoxFit.fill,
                ),
              )
            ),
            const SizedBox(height: 20),
            Text(
              vendors.name!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 10),
            Text(
              vendors.location!,
              style: const TextStyle(color: Colors.grey, fontSize: 15),
            )
          ],
        ),
      ),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Venues",
        style: TextStyle(color: Colors.black, fontSize: 15),
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
            builder: (context) => const VendorsScreen()
          ));
        }
      ),
    );
  }
}