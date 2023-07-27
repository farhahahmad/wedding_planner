import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/add_product.dart';
import 'package:wedding_planner/view/drawer.dart';
import 'package:wedding_planner/view/my_orders.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

   
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        key: _key,
        drawer: const DrawerUser(),
        appBar: AppBar(
         title: const Text(
            "My Account",
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
                  child: _menuOption("My Profile", Icons.person)
                ),
                _divider(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const MyOrders()
                    ));
                  },
                  child: _menuOption("My Orders", Icons.description)
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
