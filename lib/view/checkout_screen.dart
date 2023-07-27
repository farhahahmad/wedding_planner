// This code represents the checkout screen where user can enter shipping information and proceed to confirm their order

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/cart_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_planner/view/make_payment.dart';

String userid = "";

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

   
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  double totalAll = 0, totalPrice = 0;
  String measure = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('userid')??'');
    });

    final Query query = FirebaseFirestore.instance.collection('cart')
      .where("userid", isEqualTo: userid);

    // get the total price of items in cart
    query.get().then((QuerySnapshot querySnapshot) {
      for (int i=0 ; i<querySnapshot.size; i++) {
        final DocumentSnapshot documentSnapshot = querySnapshot.docs[i];
        double price = documentSnapshot["price"]*documentSnapshot["quantity"];
        totalPrice = totalPrice + price;
        totalAll = totalPrice;
      }
    });
  }

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: const Text(
            "Checkout",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17
            ),
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
                builder: (context) => const CartScreen()
              ));
            }
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Shipping Information",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    )
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Full name is required");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    nameController.text = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Phone number is required");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneController.text = value!;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                      labelText: 'Detailed Address',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Address is required");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    addressController.text = value!;
                  },
                ),
                const SizedBox(height: 50),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Delivery Method",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    )
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        border: OutlineInputBorder()),
                    items: const [
                      DropdownMenuItem(
                        value: "Standard Delivery",
                        child: Text("Standard Delivery", style: TextStyle(fontSize: 15)),
                      ),
                      DropdownMenuItem(
                        value: "Pickup",
                        child: Text("Pickup", style: TextStyle(fontSize: 15)),
                      )
                    ],
                    hint: const Text("Select item", style: TextStyle(fontSize: 15)),
                    onChanged: (value) {
                      setState(() {
                        measure = value!;

                        if (measure == "Standard Delivery") {
                          totalAll = totalPrice + 7;
                        } else {
                          totalAll = totalPrice;
                        }
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        measure = value!;
                      });
                    }
                  ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Cost",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                    Text(
                      "RM ${totalAll.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
              ),
        ),
      floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 80,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(50),
              backgroundColor: HexColor("#B69EA2")
            ),
            child: const Text('Confirm', style: TextStyle(fontSize: 15)),
            onPressed: () async {

              // Adds the order details to the 'orders' collection and creates entries in the 'orderitems' collection for each cart item.
              // The cart items are then deleted from the 'cart' collection

              if (_formKey.currentState!.validate()) {

                DocumentReference docRef = await FirebaseFirestore.instance.collection("orders").add({
                  "userid" : userid,
                  "fullname" : nameController.text,
                  "phone" : phoneController.text,
                  "address" : addressController.text,
                  "delivery" : measure,
                  "subtotal" : totalPrice,
                  "total" : totalAll,
                  "payment" : "Pending",
                  "status" : "Accepted"
                });

                final Query query = FirebaseFirestore.instance.collection('cart')
                  .where("userid", isEqualTo: userid);

                query.get().then((QuerySnapshot querySnapshot) {
                  for (int i=0 ; i<querySnapshot.size; i++) {
                    final DocumentSnapshot documentSnapshot = querySnapshot.docs[i];

                     FirebaseFirestore.instance.collection("orderitems").add({
                      "userid" : userid,
                      "orderid" : docRef.id,
                      "productid" : documentSnapshot["productid"],
                      "name" : documentSnapshot["name"],
                      "price" : documentSnapshot["price"],
                      "quantity" : documentSnapshot["quantity"],
                      "image" : documentSnapshot["image"],
                      "total" : documentSnapshot["total"]
                    });

                    FirebaseFirestore.instance.collection("cart").doc(documentSnapshot.id).delete();
                  }
                });

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const makePayment()
                ));
              }
            },
          )
        ),
      );
   }
}