// This code creates a functional register user interface with form validation, allowing users to enter their email, password and username. 

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/controller/user_controller.dart';
import 'package:wedding_planner/view/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
   
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final UserController _con = UserController();
  final _formKey = GlobalKey<FormState>();
  final userNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

   @override
    Widget build(BuildContext context) {

      return Material(
        color: HexColor("#FFFBFF"),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Image(image: AssetImage("images/logo.png")),
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Enter your credentials to continue",
                      style: TextStyle(color: Colors.grey[600], fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    autofocus: false,
                    controller: userNameEditingController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{3,}$');
                      if (value!.isEmpty) {
                        return ("First Name cannot be Empty");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid name(Min. 3 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userNameEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter Your Username',
                      labelText: 'Username',
                    ),
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      emailEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Enter Your Email',
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: passwordEditingController,
                    obscureText: true,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      passwordEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: HexColor("#B69EA2")
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 15)
                      ),
                      onPressed: () {
                        // Entered credentials are sent to the user controller to process sign  up function
                        _con.signUp(
                          _formKey.currentState!.validate(), 
                          emailEditingController.text, 
                          passwordEditingController.text,
                          userNameEditingController.text,
                          context);
                      },
                    )
                  ),
                  // Navigate to the login screen if user already have account
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 15)
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const LoginScreen()
                          ));
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: HexColor("#B69EA2"), fontSize: 15),
                        ),
                      ),
                    ],
                  ),   
                ],
              ),
            ),
          ),
        )
      );
   }
}