// This code displays the details of an order

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/orderitems_model.dart';
import 'package:wedding_planner/model/orders_model.dart';
import 'package:wedding_planner/view/my_order_details_status.dart';
import 'package:wedding_planner/view/my_orders.dart';

class MyOrderDetails extends StatefulWidget {

  final OrdersModel order;
  const MyOrderDetails({super.key, required this.order});

  @override
  State<MyOrderDetails> createState() => _MyOrderDetailsState();
}

class _MyOrderDetailsState extends State<MyOrderDetails> {

  late final Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();

    // Fetches real-time data from the "orderitems" collection in the Firestore database.
    _stream = FirebaseFirestore.instance.collection("orderitems")
    .where("orderid", isEqualTo: widget.order.id).snapshots();
  }

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: HexColor("#F3EBEC"),
        appBar: AppBar(
         title: const Text(
            "Order Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: HexColor("#F3EBEC"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: HexColor("#B69EA2"),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const MyOrders()
              ));
            }
          ),
        ),
        body: SafeArea(
          child: Expanded(
            child: ListView(
              children: [
                _order(),
                _orderItems(),
                _orderTotal(),
              ],
            ),
          ),
        ),
      );
   }

  // This method displays the order total
  Container _orderTotal() {
    double shipping = widget.order.total! - widget.order.subtotal!;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const Text(
              "Order Total",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
          ),
          Divider(
            color: HexColor("#E2E2E2"),
            height: 25,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          _orderRow("Total Amount", "RM ${widget.order.subtotal!.toStringAsFixed(2)}"),
          const SizedBox(height: 20),
          _orderRow("Shipping Fee", "RM ${shipping.toStringAsFixed(2)}",),
          const SizedBox(height: 20),
          _orderRow("Total", "RM ${widget.order.total!.toStringAsFixed(2)}"),
          const SizedBox(height: 10),
        ]
      )
    );
   }

  // This method displays the list of order items
  // It uses a StreamBuilder to listen to the Firestore stream and dynamically 
  //builds the list of order items based on the data received
  Container _orderItems() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: const Text(
              "Order Items",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
          ),
          Divider(
            color: HexColor("#E2E2E2"),
            height: 25,
            thickness: 1,
          ),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } 
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  OrderitemsModel orderitems = OrderitemsModel(
                    id: document["id"],
                    orderid: document["orderid"],
                    userid: document["userid"],
                    productid: document["productid"],
                    name: document["name"],
                    price: double.parse(document["price"].toString()),
                    quantity: int.parse(document["quantity"].toString()),
                    image: document["image"],
                    total: double.parse(document["total"].toString())
                  );
    
                  return _orderItemsTile(orderitems);
                } 
              );
            }
          ),
          const SizedBox(height: 10),
        ]
      )
    );
   }

  // This method builds a ListTile for each order item
  ListTile _orderItemsTile(OrderitemsModel orderitem) {
    return ListTile(
      leading: Image(image: NetworkImage(orderitem.image!)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Text(
              orderitem.name!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,5,0,5),
            child: Text(
              "RM ${orderitem.price!.toStringAsFixed(2)}", 
              style: const TextStyle(fontSize: 15)
            ),
          ),
        ],
      ),
      trailing: Text(
        "x ${orderitem.quantity!}", 
        style: const TextStyle(fontSize: 15)
      ),
    );
  }

  // This method displays the general order details
  // and navigate to the "Delivery Status" screen
  Container _order() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                Icons.description,
                color: HexColor("#B69EA2"),
                size: 40,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order: #${widget.order.id!.substring(0,7)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.order.status!, 
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.bold, 
                      color: HexColor("#B69EA2"))
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
          _orderRow("Name: ", widget.order.fullname!),
          const SizedBox(height: 20),
          _orderRow("Phone Number", widget.order.phone!),
          const SizedBox(height: 20),
          _orderRow("Address", widget.order.address!),
          const SizedBox(height: 20),
          Divider(
            color: HexColor("#E2E2E2"),
            height: 25,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: Row(
              children: [
                Text(
                  "Delivery Status", 
                  style: const TextStyle(fontSize: 15)
                ), 
                const Spacer(),
                Icon(Icons.arrow_forward_ios, color: HexColor("#C0ABAF"))
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MyOrderDetailsStatus(order: widget.order)
              ));
            },
          ),
          const SizedBox(height: 10),
        ]
      )
    );
   }

  Row _orderRow(String title, String data) {
    return Row(
      children: [
        Text(
          title, 
          style: const TextStyle(fontSize: 15)
        ), const Spacer(),
        Text(
          data,
          style: TextStyle(color: HexColor("#666666"), fontSize: 15),
        ),
      ],
    );
  }
}