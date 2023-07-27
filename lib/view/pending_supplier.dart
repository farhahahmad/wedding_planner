import 'package:flutter/material.dart';
import 'package:wedding_planner/view/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class PendingSupplier extends StatefulWidget {
  const PendingSupplier({super.key});

   
  @override
  State<PendingSupplier> createState() => _PendingSupplierState();
}

class _PendingSupplierState extends State<PendingSupplier> {
   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: const Column(
            children: [
              SizedBox(height: 70),
              Image(image: AssetImage("images/supplier_register.png")),
              SizedBox(height: 70),
              Text(
                "Pending Supplier Registration", 
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Text(
                "Your registration to become a supplier is still pending. We need to validate your business profile first. ",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ]
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
              backgroundColor: HexColor("#91777C")
            ),
            child: const Text('Back to Home', style: TextStyle(fontSize: 15),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const HomeScreen()
              ));
            },
          )
        ),
      );
   }

   AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Supplier Menu",
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
    );
  }
}