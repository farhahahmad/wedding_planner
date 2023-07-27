// This code displays the details of supplier vendor

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/vendors_model.dart';
import 'package:wedding_planner/view/supplier_vendors.dart';
import 'package:wedding_planner/view/edit_vendor.dart';

class SupplierVendorsDetails extends StatefulWidget {

  final VendorsModel vendors;
  const SupplierVendorsDetails({super.key, required this.vendors});

  @override
  State<SupplierVendorsDetails> createState() => _SupplierVendorsDetailsState();
}

class _SupplierVendorsDetailsState extends State<SupplierVendorsDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.vendors.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.vendors.location!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: NetworkImage(widget.vendors.image!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Vendor Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.vendors.description!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: HexColor("#F3F3F3"),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  leading: const Icon(Icons.sell),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Starting price",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "RM ${widget.vendors.price!.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                            ],
                  ),
                )
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // to edit the vendor
                  Column(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: HexColor("#EDE9ED"),
                          child: Icon(Icons.edit, color: HexColor("#91777C")),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => EditVendor(vendors: widget.vendors)
                          ));
                          
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("Edit", style: TextStyle(fontSize: 15))
                    ],
                  ),
                  // to delete the vendor
                  Column(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: HexColor("#EDE9ED"),
                          child: Icon(Icons.delete, color: HexColor("#B69EA2")),
                        ),
                        onTap: () {
                          showAlertDialog(context, widget.vendors);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("Delete", style: TextStyle(fontSize: 15))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  // show confirmation dialog to delete the vendor
  showAlertDialog(BuildContext context, VendorsModel vendors) {
    
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Confirm"),
      onPressed:  () {
        // delete the vendor from database
        FirebaseFirestore.instance.collection("vendors").doc(vendors.id).delete();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => const SupplierVendors()
        ));
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Vendor"),
      content: const Text("Are you confirm to delete this vendor?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Venues",
        style: TextStyle(color: Colors.black, fontSize: 17),
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
            builder: (context) => const SupplierVendors()
          ));
        }
      ),
    );
  }
}