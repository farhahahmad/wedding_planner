// This code displays the details of a supplier and provides options to approve or reject the supplier's application. 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/supplier_model.dart';
import 'package:wedding_planner/view/approve_supplier.dart';

class SupplierDetails extends StatefulWidget {
  
  final SupplierModel supplier;
  const SupplierDetails({super.key, required this.supplier});

  @override
  State<SupplierDetails> createState() => _SupplierDetailsState();
}

class _SupplierDetailsState extends State<SupplierDetails> {
   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: HexColor("#F3EBEC"),
        appBar: AppBar(
         title: const Text(
            "Supplier Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: HexColor("#F3EBEC"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ApproveSupplier()
              ));
            }
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: HexColor("#605560"),
                          size: 40,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Supplier #${widget.supplier.id!.substring(0,7)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.supplier.status!, 
                              style: TextStyle(
                                fontSize: 15, 
                                fontWeight: FontWeight.bold, 
                                color: HexColor("#605560"))
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: HexColor("#E2E2E2"),
                      height: 25,
                      thickness: 1,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Seller / Shop Name", 
                      style: TextStyle(fontSize: 15)
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.supplier.name!,
                      style: TextStyle(color: HexColor("#666666"), fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Email", 
                      style: TextStyle(fontSize: 15)
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.supplier.email!,
                      style: TextStyle(color: HexColor("#666666"), fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Contact Number", 
                      style: TextStyle(fontSize: 15)
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.supplier.phone!,
                      style: TextStyle(color: HexColor("#666666"), fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "SSM Registration Number", 
                      style: TextStyle(fontSize: 15)
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.supplier.ssm!,
                      style: TextStyle(color: HexColor("#666666"), fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                  ]
                )
              ),
              widget.supplier.status == "Pending"? 
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Colors.white,
                              side: BorderSide(color: HexColor("#605560"),width: 2)
                            ),
                            child: const Text(
                              'Reject',
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            onPressed: () {
                              // update the supplier's status in the Firestore database
                              FirebaseFirestore.instance.collection("supplier").doc(widget.supplier.id).update({
                                "status" : "Rejected"
                              });
                              Fluttertoast.showToast(msg: "Successfully update");
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const ApproveSupplier()
                              ));
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: HexColor("#605560")
                            ),
                            child: const Text('Approve', style: TextStyle(fontSize: 15)),
                            onPressed: () {
                              // update the supplier's status in the Firestore database
                              FirebaseFirestore.instance.collection("supplier").doc(widget.supplier.id).update({
                                "status" : "Approved"
                              });
                              Fluttertoast.showToast(msg: "Successfully update");
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const ApproveSupplier()
                              ));
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ) : Container()
            ],
          )
        ),
      );
   }
}