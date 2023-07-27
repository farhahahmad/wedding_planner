import 'package:flutter/material.dart';
import 'package:wedding_planner/view/account_screen.dart';
import 'package:wedding_planner/view/home_screen.dart';
import 'package:wedding_planner/view/login_screen.dart';
import 'package:wedding_planner/view/marriage_procedure_menu.dart';
import 'package:wedding_planner/view/planner_screen.dart';
import 'package:wedding_planner/view/registered_supplier_menu.dart';
import 'package:wedding_planner/view/shop_screen.dart';
import 'package:wedding_planner/view/supplier_menu.dart';
import 'package:wedding_planner/view/vendors_screen.dart';
import 'package:wedding_planner/view/wedding_inspirations.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userid = "";
String isSupplier = "";

class DrawerUser extends StatefulWidget {
  const DrawerUser({super.key});

   
  @override
  State<DrawerUser> createState() => _DrawerUserState();
}

class _DrawerUserState extends State<DrawerUser> {

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('userid')??'');
      isSupplier = (prefs.getString('isSupplier')??'');
    });
  }

   @override
    Widget build(BuildContext context) {

      return Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const HomeScreen()
                ));
              },
              leading: const Icon(Icons.home),
              title: const Text("Home", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const AccountScreen()
                ));
              },
              leading: const Icon(Icons.person),
              title: const Text("Account", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const PlannerScreen()
                ));
              },
              leading: const Icon(Icons.edit),
              title: const Text("Planner", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const MarriageProcedureMenu()
                ));
              },
              leading: const Icon(Icons.description),
              title: const Text("Procedure", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const ShopScreen()
                ));
              },
              leading: const Icon(Icons.shopping_bag),
              title: const Text("Shop", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const VendorsScreen()
                ));
              },
              leading: const Icon(Icons.store),
              title: const Text("Vendors", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const WeddingInspirations()
                ));
              },
              leading: const Icon(Icons.filter_vintage),
              title: const Text("Inspiration", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () {
                print("sussssssss$isSupplier");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    if (isSupplier == "true") {
                      return const RegisteredSupplierMenu();
                    }
                    else {
                      return const SupplierMenu();
                    }
                  }
                ));
              },
              leading: const Icon(Icons.sell),
              title: const Text("Supplier Menu", style: TextStyle(fontSize: 15)),
            ),
            ListTile(
              onTap: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove("userid");
                pref.remove("isSupplier");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const LoginScreen()
                ));
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout", style: TextStyle(fontSize: 15)),
            ),
            const ListTile(),
            // ListTile(
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(
            //       builder: (context) => const AdminHome()
            //     ));
            //   },
            //   title: const Text("Admin", style: TextStyle(fontSize: 15)),
            // ),
          ],
        ),
      );
   }
}