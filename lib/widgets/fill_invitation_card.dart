import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget buildTemplate1({
  required double width,
  required double height,
  required String name1,
  required String name2,
  required String location,
  required String date,
  required String time,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 167, 167, 167)),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      image: const DecorationImage(
        image: AssetImage("images/card1_empty.png"),
        fit:BoxFit.fill
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "YOU'RE INVITED TO \nOUR WEDDING", 
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 2.0,
              color: Colors.black)
          ),
          const SizedBox(height: 40),
          Text(
            name1, 
            style: const TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black)
          ),
          const SizedBox(height: 20),
          const Text(
            "AND", 
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black)
          ),
          const SizedBox(height: 20),
          Text(
            name2, 
            style: const TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.black)
          ),
          const SizedBox(height: 50),
          Text(
            date, 
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black)
          ),
          const SizedBox(height: 8),
          Text(
            time, 
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black)
          ),
          const SizedBox(height: 8),
          Text(
            location, 
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black)
          ),
        ],
      ),
    )
  );
}


Widget buildTemplate2({
  required double width,
  required double height,
  required String name1,
  required String name2,
  required String location,
  required String date,
  required String time,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 167, 167, 167)),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      image: const DecorationImage(
        image: AssetImage("images/card2_empty.png"),
        fit:BoxFit.fill
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 120),
          Text(
            name1, 
            style: const TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.black)
          ),
          const SizedBox(height: 5),
          const Text(
            "and", 
            style: TextStyle(
              fontFamily: 'OoohBaby', 
              fontSize: 25,
              color: Colors.black)
          ),
          const SizedBox(height: 5),
          Text(
            name2, 
            style: const TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.black)
          ),
          const SizedBox(height: 40),
          const Text(
            "We invite you to share \n with us a celebration of \n love and commitment",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.5,
              color: Colors.black)
          ),
          const SizedBox(height: 30),
          Text(
            date, 
            style: const TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.black)
          ),
          const SizedBox(height: 8),
          Text(
            time, 
            style: const TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Colors.black)
          ),
          const SizedBox(height: 30),
          Text(
            location, 
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black)
          ),
        ],
      ),
    )
  );
}


Widget buildTemplate3({
  required double width,
  required double height,
  required String name1,
  required String name2,
  required String location,
  required String date,
  required String time,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 167, 167, 167)),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      image: const DecorationImage(
        image: AssetImage("images/card3_empty.png"),
        fit:BoxFit.fill
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name1, 
            style: TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: HexColor("#B48B58"))
          ),
          const SizedBox(height: 5),
          Text(
            "and", 
            style: TextStyle(
              fontFamily: 'OoohBaby', 
              fontSize: 25,
              color: HexColor("#B48B58"))
          ),
          const SizedBox(height: 5),
          Text(
            name2, 
            style: TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: HexColor("#B48B58"))
          ),
          const SizedBox(height: 40),
          Text(
            "Together with families, \n we invite you to our wedding",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.5,
              color: HexColor("#29536F"))
          ),
          const SizedBox(height: 40),
          Text(
            date.toUpperCase(), 
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: HexColor("#29536F"))
          ),
          const SizedBox(height: 10),
          Text(
            time.toUpperCase(), 
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: HexColor("#29536F"))
          ),
          const SizedBox(height: 10),
          Text(
            location.toUpperCase(), 
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: HexColor("#29536F"))
          ),
        ],
      ),
    )
  );
}


Widget buildTemplate4({
  required double width,
  required double height,
  required String name1,
  required String name2,
  required String location,
  required String date,
  required String time,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 167, 167, 167)),
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      image: const DecorationImage(
        image: AssetImage("images/card4_empty.png"),
        fit:BoxFit.fill
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(height: 120),
          Text(
            name1, 
            style: TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: HexColor("#B48B58"))
          ),
          const SizedBox(height: 5),
          Text(
            "and", 
            style: TextStyle(
              fontFamily: 'OoohBaby', 
              fontSize: 25,
              color: HexColor("#B48B58"))
          ),
          const SizedBox(height: 5),
          Text(
            name2, 
            style: TextStyle(
              fontFamily: 'OoohBaby', 
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: HexColor("#B48B58"))
          ),
          const SizedBox(height: 50),
          Text(
            "with full hearts, \n joyfully invite you to their wedding",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.5,
              color: HexColor("#765830"))
          ),
          const SizedBox(height: 50),
          Text(
            date.toUpperCase(), 
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: HexColor("#765830"))
          ),
          const SizedBox(height: 10),
          Text(
            time.toUpperCase(), 
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: HexColor("#765830"))
          ),
          const SizedBox(height: 10),
          Text(
            location.toUpperCase(), 
            style: TextStyle(
              fontFamily: 'Lucida',
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: HexColor("#765830"))
          ),
        ],
      ),
    )
  );
}