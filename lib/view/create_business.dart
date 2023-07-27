// This code represents allows users to create their business profile to become a supplier in the system

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/pending_supplier.dart';
import 'package:wedding_planner/view/shop_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userid = "";

class CreateBusiness extends StatefulWidget {
  const CreateBusiness({super.key});

   
  @override
  State<CreateBusiness> createState() => _CreateBusinessState();
}

class _CreateBusinessState extends State<CreateBusiness> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ssmController = TextEditingController();

    @override
  void initState() {
    super.initState();
    _loadUser();
  }

  _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('userid')??'');
    });
  }

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: const Text(
            "Create Business Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 15
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: HexColor("#91777C"),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ShopScreen()
              ));
            }
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Create your business profile to become a supplier in myWedding. Fill in the details below.",
                      style: TextStyle(fontSize: 15)
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Seller / Shop Name',
                          labelStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter your name");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        nameController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter your phone number");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phoneController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter your email");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'SSM Registration Number ',
                          labelStyle: TextStyle(fontSize: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          border: OutlineInputBorder()),
                      controller: ssmController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please enter your SSM");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ssmController.text = value!;
                      },
                    ),
                    
                  ]
                ),
              )
            )
          )
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
            child: const Text('Register as Supplier', style: TextStyle(fontSize: 15)),
            onPressed: () async {

              // Adds the supplier's details to the 'supplier' collection in Firestore with a status of "Pending".  
              FirebaseFirestore.instance.collection("supplier").add({
                "name" : nameController.text, 
                "phone" : phoneController.text,
                "email" : emailController.text,
                "ssm" : ssmController.text,
                "userid" : userid,
                "status" : "Pending"
              });

              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('isSupplier', "true");

              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const PendingSupplier()
              ));
            },
          )
        ),
      );
   }
}