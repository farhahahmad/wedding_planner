// This code displays a list of supplier products 

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/products_model.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/edit_product.dart';
import 'package:wedding_planner/view/product_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wedding_planner/view/registered_supplier_menu.dart';

class SupplierProducts extends StatefulWidget {
  const SupplierProducts({super.key});

   
  @override
  State<SupplierProducts> createState() => _SupplierProductsState();
}

class _SupplierProductsState extends State<SupplierProducts> {

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
            "Products",
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
                builder: (context) => const RegisteredSupplierMenu()
              ));
            }
          ),
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
                // to edit the product
                CircleAvatar(
                  radius: 20,
                  backgroundColor: HexColor("#C0ABAF"),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EditProduct(products: products)
                      ));
                    }, 
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                // to delete the product
                CircleAvatar(
                  radius: 20,
                  backgroundColor: HexColor("#C0ABAF"),
                  child: IconButton(
                    onPressed: () {
                      showAlertDialog(context, products);
                    }, 
                    icon: const Icon(Icons.delete),
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

  // show confirmation dialog to delete product
  showAlertDialog(BuildContext context, ProductsModel products) {
  
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Confirm"),
      onPressed:  () {
        // delete the product from database
        FirebaseFirestore.instance.collection("products").doc(products.id).delete();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Product"),
      content: const Text("Are you confirm to delete this product?"),
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
}