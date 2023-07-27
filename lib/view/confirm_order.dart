import 'package:flutter/material.dart';
import 'package:wedding_planner/view/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';

class ConfirmOrder extends StatefulWidget {
  const ConfirmOrder({super.key});

   
  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
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
              Image(image: AssetImage("images/confirm_order.png")),
              SizedBox(height: 70),
              Text(
                "Your order has been accepted", 
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25),
              Text(
                "Your order has been confirmed and is on its way to being processed",
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
        "Order Confirmed",
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.arrow_back_ios,
      //     color: Colors.black,
      //   ),
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(
      //       builder: (context) => CheckoutScreen()
      //     ));
      //   }
      // ),
    );
  }
}