// This code representing a menu screen for a registered supplier

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/add_product.dart';
import 'package:wedding_planner/view/add_vendor.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/supplier_orders.dart';
import 'package:wedding_planner/view/supplier_products.dart';
import 'package:wedding_planner/view/supplier_vendors.dart';

class RegisteredSupplierMenu extends StatefulWidget {
  const RegisteredSupplierMenu({super.key});

   
  @override
  State<RegisteredSupplierMenu> createState() => _RegisteredSupplierMenuState();
}

class _RegisteredSupplierMenuState extends State<RegisteredSupplierMenu> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        key: _key,
        drawer: const DrawerUser(),
        appBar: AppBar(
         title: const Text(
            "Supplier Menu",
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
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
            _key.currentState?.openDrawer();
          }
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const AddProduct()
                    ));
                  },
                  child: _menuOption("Add Product", Icons.add_shopping_cart)
                ),
                _divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const AddVendor()
                    ));
                  },
                  child: _menuOption("Add Vendor", Icons.add_home_work)
                ),
                _divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SupplierProducts()
                    ));
                  },
                  child: _menuOption("My Products", Icons.shopping_cart)
                ),
                _divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SupplierVendors()
                    ));
                  },
                  child: _menuOption("My Vendors", Icons.home_work)
                ),
                _divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SupplierOrders()
                    ));
                  },
                  child: _menuOption("Orders", Icons.description)
                ),
                _divider(),
              ],
            ),
          )
        )
      );
   }

   Divider _divider() {
      return Divider(
        color: HexColor("#E2E2E2"),
        height: 25,
        thickness: 1,
        indent: 5,
        endIndent: 5,
      );
   }

  // This method is defined to represent each menu option 
  // and navigates to the corresponding screen
   Container _menuOption(String title, IconData icon) {
     return Container(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: Icon(
            icon,
            color: HexColor("#B69EA2"),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 15)
          ),
          trailing: IconButton(
            color: Colors.black,
            iconSize: 18,
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () { },
          ),
        ),
      );
   }
}
