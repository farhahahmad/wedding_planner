// This code displays a list of orders for supplier

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/orders_model.dart';
import 'package:wedding_planner/view/registered_supplier_menu.dart';
import 'package:wedding_planner/view/supplier_order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupplierOrders extends StatefulWidget {
  const SupplierOrders({Key? key}) : super(key: key);

  @override
  State<SupplierOrders> createState() => _SupplierOrdersState();
}

class _SupplierOrdersState extends State<SupplierOrders> {

  // Fetches real-time data from the "orders" collection in the Firestore database.
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("orders").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#F3EBEC"),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                          OrdersModel order = OrdersModel(
                            id: snapshot.data?.docs[index].id,
                            userid: document["userid"],
                            fullname: document["fullname"],
                            phone: document["phone"],
                            address: document["address"],
                            subtotal: double.parse(document["subtotal"].toString()),
                            total: double.parse(document["total"].toString()),
                            payment: document["payment"],
                            delivery: document["delivery"],
                            status: document["status"]);

                          return _supplierBox(order);
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

  Container _supplierBox(OrdersModel order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => SupplierOrderDetails(order: order)
          ));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        contentPadding: const EdgeInsets.all(15),
        // tileColor: Color.fromARGB(255, 220, 220, 220),
        tileColor: Colors.white,
        leading: Icon(Icons.description,
          color: HexColor("#B69EA2"),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order: #${order.id!.substring(0,7)}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 10),
            Text(
              "RM${order.total!.toStringAsFixed(2)}",
              style: TextStyle(
                color: HexColor("#666666"),
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        trailing: Text(
          order.status!,
          style: TextStyle(
            color: HexColor("#B69EA2"), 
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
        "Orders",
        style: TextStyle(
          color: Colors.black, 
          fontSize: 17
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: HexColor("#F3EBEC"),
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
            builder: (context) => const RegisteredSupplierMenu()
          ));
        }
      ),
    );
  }
}