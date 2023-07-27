// This code displays the details of a marriage procedure using the Quill rich text editor

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/view/marriage_procedure_menu.dart';
import 'package:url_launcher/url_launcher.dart';


class ProcedureDetails extends StatefulWidget {

  final String title;
  final String docName;
  const ProcedureDetails({super.key, required this.title, required this.docName});
   
  @override
  State<ProcedureDetails> createState() => _ProcedureDetailsState();
}

class _ProcedureDetailsState extends State<ProcedureDetails> {

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: HexColor("#FFFBFF"),
        appBar: AppBar(
          backgroundColor: HexColor("#FFFBFF"),
         title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 17
          ),
          ),
          centerTitle: true,
          elevation: 0.0,
          shape: const Border(
            bottom: BorderSide(
              color: Color.fromARGB(255, 218, 218, 218),
              width: 1
            )
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const MarriageProcedureMenu()
              ));
            }
          ),
        ),
        body: Container(
          // fetches the procedure details from the Firestore database
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('procedure').doc(widget.docName).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
              var userDocument = snapshot.data;
              return QuillEditor(
                controller: QuillController(
                  document: Document.fromJson(userDocument!["text"]),
                  selection: const TextSelection.collapsed(offset: 0),
                ),
                embedBuilders: FlutterQuillEmbeds.builders(),
                showCursor: false,
                readOnly: true, 
                autoFocus: true, 
                expands: true, 
                focusNode: FocusNode(), 
                padding: const EdgeInsets.all(20), 
                scrollController: ScrollController(), 
                scrollable: true,
              );
            }
          ),
        )
      );
    }

  Future<void> launchURL(String url) async {
    if (!await launchUrl(url as Uri)) {
    throw Exception('Could not launch $url');
  }
  }
}