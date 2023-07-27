// This code is a Flutter app that displays the delivery status of an order

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/orders_model.dart';
import 'package:wedding_planner/view/my_order_details.dart';

class MyOrderDetailsStatus extends StatefulWidget {

  final OrdersModel order;
  MyOrderDetailsStatus({required this.order});
   
  @override
  State<MyOrderDetailsStatus> createState() => _MyOrderDetailsStatusState();
}

class _MyOrderDetailsStatusState extends State<MyOrderDetailsStatus> {
   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: const Text(
            "Delivery Status",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: HexColor("#B69EA2"),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MyOrderDetails(order: widget.order)
              ));
            }
          ),
        ),
        body: SafeArea(
          child: Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Image(image: AssetImage("images/order_status1.png")),
                      SizedBox(width: 10),
                      Expanded(child: Text("Order Accepted", style: TextStyle(fontSize: 15))),
                      Icon(Icons.check_box, color: HexColor("#B69EA2"))
                    ],
                  ),
                  SizedBox(height: 40),
                  _prepared(widget.order.status!),
                  SizedBox(height: 40),
                  _delivered(widget.order.status!),
                  SizedBox(height: 40),
                  _receivedButton(context, widget.order.status!),
                  _received(widget.order.status!),
                ]
              ),
            ),
          ),
        )
      );
   }

  Row _received(String status) {
    if (status == "Received") {
      return Row(
        children: [
          Image(image: AssetImage("images/order_status4.png")),
          SizedBox(width: 10),
          Expanded(child: Text("Order Received", style: TextStyle(fontSize: 15)))
        ],
      );
    } else {
      return Row(children: []);
    }
  }

  Expanded _receivedButton(BuildContext context, String status) {
    if (status == "Shipped") {
      return Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child:Container(
            margin: const EdgeInsets.all(20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                minimumSize: const Size.fromHeight(50),
                backgroundColor: HexColor("#B69EA2")
              ),
              child: const Text('Order Received', style: TextStyle(fontSize: 15)),
              onPressed: () {
                FirebaseFirestore.instance.collection("orders").doc(widget.order.id).update({
                  "status" : "Received"
                });
                Fluttertoast.showToast(msg: "Successfully update");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => MyOrderDetails(order: widget.order)
                ));
              },
            ),
          )
        ),
      );
    } else {
      return Expanded(child: Container());
    }
  }

  Row _delivered(String status) {
    if (status == "Shipped" || status == "Received") {
      return Row(
        children: [
          Image(image: AssetImage("images/order_status3.png")),
          SizedBox(width: 10),
          Expanded(child: Text("Order Is Being Delivered", style: TextStyle(fontSize: 15))),
          Icon(Icons.check_box, color: HexColor("#B69EA2"))
        ],
      );
    } else {
      return Row(children: []);
    }
  }

  Row _prepared(String status) {
    if (status == "Accepted") {
      return Row(children: []);
    } else {
      return Row(
        children: [
          Image(image: AssetImage("images/order_status2.png")),
          SizedBox(width: 10),
          Expanded(child: Text("Order Is Being Prepared", style: TextStyle(fontSize: 15))),
          Icon(Icons.check_box, color: HexColor("#B69EA2"))
        ],
      );
    }
   }
}