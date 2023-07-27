// This code displays the details of a product and can add the product to the shopping cart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/products_model.dart';
import 'package:wedding_planner/view/shop_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {

  final ProductsModel products;
  const ProductDetails({super.key, required this.products});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Displays the product information
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.products.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(widget.products.image!),
                    fit: BoxFit.fill,
                  ),
                ),
                const Text(
                  "Product Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.products.description!,
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
                        Text(
                          "RM ${widget.products.price!.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.products.packing!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15
                          ),
                        ),
                              ],
                    ),
                  )
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
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
            child: const Text('Add to Cart', style: TextStyle(fontSize: 15),),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              var userid = prefs.getString("userid");

              final Query query = FirebaseFirestore.instance.collection('cart')
                .where("userid", isEqualTo: userid)
                .where("productid", isEqualTo: widget.products.id).limit(1);

              query.get().then((QuerySnapshot querySnapshot) {
                if (querySnapshot.size > 0) {  // checks if product exist in cart
                  print('Document exists');
                  final DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

                  String cartid = documentSnapshot.id; 
                  int qty = documentSnapshot["quantity"] + 1;
                  double tot = documentSnapshot["price"] * qty;

                  FirebaseFirestore.instance.collection("cart").doc(cartid).update({
                    "quantity" : qty,
                    "total" : tot
                  });
                  
                } else {
                  print('Document does not exist');
                  // A new document is added to the cart collection in Firestore, representing the product in the user's cart.

                  FirebaseFirestore.instance.collection("cart").add({
                    "userid" : userid,
                    "productid" : widget.products.id,
                    "name" : widget.products.name,
                    "price" : widget.products.price,
                    "quantity" : 1,
                    "image" : widget.products.image,
                    "total" : widget.products.price
                  });
                }

                Fluttertoast.showToast(msg: "Added to Cart");
              }).catchError((error) {
                print('Error getting document: $error');
              });
            },
          )
        ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Product",
        style: TextStyle(color: Colors.black, fontSize: 17),
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
            builder: (context) => const ShopScreen()
          ));
        }
      ),
    );
  }
}