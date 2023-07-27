// This code allows the admin to update the marriage procedure in the application

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/admin_home.dart';
import 'package:wedding_planner/view/admin_procedure.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class UpdateProcedure extends StatefulWidget {

  final String title;
  final String docName;
  const UpdateProcedure({super.key, required this.title,required this.docName});
   
  @override
  State<UpdateProcedure> createState() => _UpdateProcedureState();
}

class _UpdateProcedureState extends State<UpdateProcedure> {

   @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: Text(
            widget.title,
            style: const TextStyle(color: Colors.black, fontSize: 17),
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
                builder: (context) => const AdminHome()
              ));
            }
          ),
        ),
        body: StreamBuilder(
          // Fetches data from the "prodcedure" collection in the Firestore database.
          stream: FirebaseFirestore.instance.collection('procedure').doc(widget.docName).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
              var userDocument = snapshot.data;

              // Initialize QuillController with the existing procedure text fetched from Firestore
              QuillController controller = QuillController(
                document: Document.fromJson(userDocument!["text"]),
                selection: const TextSelection.collapsed(offset: 0),
              );

              return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // QuillToolbar provide text formatting, headings, lists, images, and others
                    QuillToolbar.basic(
                      controller: controller,
                      embedButtons: FlutterQuillEmbeds.buttons(),
                    ),
                    // Quill Editor allows the admin to edit the procedure text
                    Expanded(
                      child: Container(
                        child: QuillEditor.basic(
                          controller: controller,
                          readOnly: false, 
                          embedBuilders: FlutterQuillEmbeds.builders(),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: HexColor("#605560")
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          // Update the procedure in database
                          FirebaseFirestore.instance.collection("procedure").doc(widget.docName).update({
                            "text" : controller.document.toDelta().toJson()
                          });

                          Fluttertoast.showToast(msg: "Successfully update");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const AdminProcedure()
                          ));
                        },
                      )
                    ),
                  ],
                ),
              );
            }
        )
      );
    }
}