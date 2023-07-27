// This code represents cart screen that allows users to view and manage items added to their cart.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/cart_model.dart';
import 'package:wedding_planner/view/checkout_screen.dart';
import 'package:wedding_planner/view/shop_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userid = "";

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

   
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  late final Stream<QuerySnapshot> _stream;

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

    // Fetches real-time data from the "cart" collection in the Firestore database.
    _stream = FirebaseFirestore.instance.collection("cart").where("userid", isEqualTo: userid).snapshots();
  
  }

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
         title: const Text(
          "Cart",
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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ShopScreen()
              ));
            }
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),

          // Listens to the cart stream and rebuilds the UI whenever new data is received from the database
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
                  CartModel cart = CartModel(
                    id: snapshot.data?.docs[index].id,
                    userid: document["userid"], 
                    productid: document["productid"], 
                    name: document["name"], 
                    price: document["price"], 
                    quantity: document["quantity"], 
                    image: document["image"],
                    total: document["total"]);
                  return _cartItem(cart);
                } 
              );
            },
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
              backgroundColor: HexColor("#C0ABAF")
            ),
            child: const Text('Checkout', style: TextStyle(fontSize: 15)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const CheckoutScreen()
              ));
            },
          )
        ),
      );
    }

  // Create a cart item that displays the item information along with buttons to manage the quantity and remove the item.
  SizedBox _cartItem(CartModel cart) {
    return SizedBox(
      width: double.infinity,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 100,
              child: Image(
                image: NetworkImage(cart.image!)
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,5,0,5),
                    child: Text(
                      cart.name!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,5,0,5),
                    child: Text("RM ${cart.price!.toStringAsFixed(2)}", style: const TextStyle(fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15,5,0,5),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor("#C0ABAF")
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ), 
                            onPressed: () { 
                              int qty = cart.quantity! + 1;
                              double tot = cart.price! * qty;

                              FirebaseFirestore.instance.collection("cart").doc(cart.id).update({
                                "quantity" : qty,
                                "total" : tot
                              });
                            },
                          )
                        ),
                        const SizedBox(width: 10),
                        Text(cart.quantity.toString(), style: const TextStyle(fontSize: 15)),
                        const SizedBox(width: 10),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor("#C0ABAF")
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ), 
                            onPressed: () { 

                              if (cart.quantity == 1) {
                                FirebaseFirestore.instance.collection("cart").doc(cart.id).delete();
                              } else {
                                int qty = cart.quantity! - 1;
                                double tot = cart.price! * qty;

                                FirebaseFirestore.instance.collection("cart").doc(cart.id).update({
                                  "quantity" : qty,
                                  "total" : tot
                                });
                              }
                            },
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: (){
                      FirebaseFirestore.instance.collection("cart").doc(cart.id).delete();
                    }, 
                    icon: Icon(
                      Icons.delete,
                      color: HexColor("#C0ABAF")
                    )
                  ),
                  Text("RM ${cart.total!.toStringAsFixed(2)}", style: const TextStyle(fontSize: 15))
                ],
              ),
            )
          ],
        ),
      ),
    );
   }
}