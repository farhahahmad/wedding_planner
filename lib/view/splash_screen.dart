import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/login_screen.dart';

class SplashScreen extends StatefulWidget {


  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int duration = 3;

   @override
    Widget build(BuildContext context) {

      Future.delayed(Duration (seconds: duration), () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => const LoginScreen()
        ));
      });

      return Scaffold(
        body: Container(
          color: HexColor("#B69EA2"),
          child: const Center(
            child: Image(image: AssetImage("images/logo_gold.png"))
          ),
      ));
   }
}