// This code creates a functional login user interface with form validation, allowing users to enter their email and password. 

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/controller/user_controller.dart';
import 'package:wedding_planner/view/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final UserController _con = UserController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                      "Login",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Enter your credentials to continue",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600]
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    autofocus: false,
                    controller: emailController,
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
                      emailController.text = value!;
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
                    controller: passwordController,
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
                      passwordController.text = value!;
                    },
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
                        'Login',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {
                        // Entered credentials are sent to the user controller to process sign in function
                        _con.signIn(
                          _formKey.currentState!.validate(),
                          emailController.text, 
                          passwordController.text,
                          context
                        );
                      },
                    )
                  ),
                  // Navigate to the registration screen if user do not have account
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const RegisterScreen()
                          ));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: HexColor("#B69EA2"),
                            fontSize: 14
                          ),
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