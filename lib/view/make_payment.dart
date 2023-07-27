import 'package:flutter/material.dart';
import 'package:wedding_planner/view/checkout_screen.dart';
import 'package:wedding_planner/services/PaypalPayment.dart';

class makePayment extends StatefulWidget {
  const makePayment({super.key});

   
  @override
  State<makePayment> createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {
   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Center(
          child: Container(
          height: 80,
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.blue
            ),
            child: const Text('Pay with Paypal', style: TextStyle(fontSize: 15),),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => PaypalPayment(onFinish: (number) async {
                  print('order id: '+number);
                })
              ));
            },
          )
        ),
        )
      );
   }

   AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Make Payment",
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
            builder: (context) => const CheckoutScreen()
          ));
        }
      ),
    );
  }
}