// This code  displays a shop screen where users can view products available for purchase. 

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/products_model.dart';
import 'package:wedding_planner/view/cart_screen.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

   
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

   @override
    Widget build(BuildContext context) {

      // Fetches real-time data from the "products" collection in the Firestore database.
      final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("products").snapshots();

      return Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        drawer: const DrawerUser(),
        appBar: AppBar(
         title: const Text(
            "Shop",
            style: TextStyle(
              color: Colors.black,
              fontSize: 17
            ),
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
            icon: Icon(
              Icons.menu,
              color: HexColor("#91777C"),
            ),
            onPressed: () {
              _key.currentState?.openDrawer();
            }
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const CartScreen()
                ));
              }, 
              icon: Icon(Icons.shopping_cart, color: HexColor("#C0ABAF"),)
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20),

          // Listens to the stream and rebuilds the UI whenever new data is received from the database
          child: StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } 
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15
                ), 
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> document = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  ProductsModel products = ProductsModel(id: snapshot.data?.docs[index].id, name: document["name"], description: document["description"], price: document["price"], quantity: document["quantity"], packing: document["packing"], image: document["image"]);
                  return _productItem(products);
                }
              );
            },
          ),
        )
      );
   }

  // This method representseach product item in the GridView and navigates to the ProductDetails screen
  GestureDetector _productItem(ProductsModel products) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductDetails(products: products)
        ));
      },
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: HexColor("#E2E2E2"),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 90,
              child: Image(image: NetworkImage(products.image!), fit: BoxFit.fill)
            ),
            const SizedBox(height: 5),
            Text(products.name!, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "RM ${products.price!.toStringAsFixed(2)}", 
                  style: const TextStyle(fontSize: 17)
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: HexColor("#C0ABAF"),
                  child: IconButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      var userid = prefs.getString("userid");

                      final Query query = FirebaseFirestore.instance.collection('cart')
                        .where("userid", isEqualTo: userid)
                        .where("productid", isEqualTo: products.id).limit(1);

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
                            "productid" : products.id,
                            "name" : products.name,
                            "price" : products.price,
                            "quantity" : 1,
                            "image" : products.image,
                            "total" : products.price
                          });
                        }

                        Fluttertoast.showToast(msg: "Added to Cart");
                      }).catchError((error) {
                        print('Error getting document: $error');
                      });
                    }, 
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
   }
}