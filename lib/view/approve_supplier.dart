// This code displays a list of suppliers and their approval status from a Cloud Firestore database.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/supplier_model.dart';
import 'package:wedding_planner/view/admin_home.dart';
import 'package:wedding_planner/view/supplier_details.dart';

class ApproveSupplier extends StatefulWidget {
  const ApproveSupplier({Key? key}) : super(key: key);

  @override
  State<ApproveSupplier> createState() => _ApproveSupplierState();
}

class _ApproveSupplierState extends State<ApproveSupplier> {

  // Fetches real-time data from the "supplier" collection in the Firestore database.
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("supplier").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            margin: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  // Listens to the supplier stream and rebuilds the UI whenever new data is received from the database
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
                          SupplierModel supplier = SupplierModel(
                            id: snapshot.data?.docs[index].id, 
                            userid: document["userid"], 
                            name: document["name"],
                            email: document["email"],
                            phone: document["phone"],
                            ssm: document["ssm"],
                            status: document["status"]);

                          return _supplierBox(supplier);
                        } 
                      );
                    }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function that display each supplier's information.
  Container _supplierBox(SupplierModel supplier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SupplierDetails(supplier: supplier)
          ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(15),
        tileColor: HexColor("#EDEDED"),
        leading: Icon(Icons.description,
          color: HexColor("#605560")
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Supplier #${supplier.id!.substring(0,7)}", style: const TextStyle(fontSize: 15)),
            Text(
              supplier.name!,
              style: TextStyle(
                color: HexColor("#666666"),
                fontSize: 15
              ),
            ),
          ],
        ),
        trailing: Text(
          supplier.status!,
          style: TextStyle(
            color: HexColor("#605560"),
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        )
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Approve Supplier",
        style: TextStyle(
          color: Colors.black, 
          fontSize: 17
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      shape: const Border(
        bottom: BorderSide(
          color: Color.fromARGB(255, 218, 218, 218),
          width: 1
        )
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => const AdminHome()
          ));
        }
      ),
    );
  }
}