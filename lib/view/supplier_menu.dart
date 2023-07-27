import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/create_business.dart';
import 'package:wedding_planner/view/drawer.dart';

class SupplierMenu extends StatefulWidget {
  const SupplierMenu({super.key});

   
  @override
  State<SupplierMenu> createState() => _SupplierMenuState();
}

class _SupplierMenuState extends State<SupplierMenu> {

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
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
          backgroundColor: HexColor("#FFFBFF"),
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
                const Image(image: AssetImage("images/supplier_bg.png")),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "The Right Place To Grow Your Wedding Business",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: HexColor("#B69EA2")
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Text('Start Selling / Become A Vendor', style: TextStyle(fontSize: 15))
                              ),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => const CreateBusiness()
                            ));
                          },
                        )
                      ),
                      const SizedBox(height: 30),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Join wedding vendors all around Malaysia who have connected with hundreds of engaged couples or start selling wedding items in myWedding today! ",
                          style: TextStyle(fontSize: 15)
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        )
      );
   }
}
