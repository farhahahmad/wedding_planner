
// This code allows users to create wedding invitation cards. 

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedding_planner/services/storage_service.dart';
import 'package:wedding_planner/view/make_invitation.dart';
import 'package:wedding_planner/widgets/fill_invitation_card.dart';
import 'package:screenshot/screenshot.dart';
import 'package:intl/intl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uuid/uuid.dart';

class InvitationCard extends StatefulWidget {

  final String imagePath;
  const InvitationCard({super.key, required this.imagePath});

  @override
  State<InvitationCard> createState() => _InvitationCardState();
}

class _InvitationCardState extends State<InvitationCard> {
  
  final TextEditingController groomNameController = TextEditingController(text: "Morgan");
  final TextEditingController brideNameController = TextEditingController(text: "Margarita");
  final TextEditingController locationController = TextEditingController(text: "Caterina Hotel, Johor Bahru");
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  Uint8List? bytes;
  StorageService storage = StorageService();

  @override
  void initState() {
    dateController.text = "August 23, 2024";
    timeController.text = "8.30 am";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height/1.5;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Invitation Card Maker",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 218, 218, 218),
            width: 1
          )
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const MakeInvitation()
            ));
          }
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildTemplate(widget.imagePath, width, height)
              ),
              const SizedBox(height: 30),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 1.12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),

                // enter details to customize invitation card
                child: TextFormField(
                  controller: groomNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hintText: "Groom's Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    var text = value.replaceAll(RegExp(r'\s+\b|\b\s'), ' ');
                    setState(() {
                      groomNameController.value = groomNameController.value.copyWith(
                          text: text,
                          selection: TextSelection.collapsed(offset: text.length),
                          composing: TextRange.empty);
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 1.12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: brideNameController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hintText: "Bride's Name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      brideNameController.value = brideNameController.value.copyWith(
                        text: value,
                        selection: TextSelection.collapsed(offset: value.length),
                        composing: TextRange.empty);
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 55,
                width: MediaQuery.of(context).size.width / 1.12,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: locationController,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    hintText: 'Location',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.home,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      locationController.value = locationController.value.copyWith(
                        text: value,
                        selection: TextSelection.collapsed(offset: value.length),
                        composing: TextRange.empty);
                    });
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: "Date",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));
        
                        if (pickedDate != null) {
                          String formattedDate = DateFormat.yMMMMd().format(pickedDate);
                          setState(() {
                            dateController.text = formattedDate; 
                          });
                        } else {}
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextFormField(
                      controller: timeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        hintText: "Time",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.timer,
                          color: Colors.grey,
                        ),
                      ),
                      onTap: () async {
                        var pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now());
        
                        if (pickedTime != null) {
                          // String formattedDate = DateFormat.yMMMMd().format(pickedDate);
                          setState(() {
                            timeController.text = "${pickedTime.hour}:${pickedTime.minute} ${pickedTime.period.toString().split('.')[1]}";
                          });
                        } else {}
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20 * 3),
              Container(
                height: 80,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: HexColor("#91777C")
                  ),
                  child: const Text('Create Invitation Card', style: TextStyle(fontSize: 15),),
                  onPressed: () async {

                    // merge the chosen template with the provided details, and the final image is stored in the Firebase Cloud Firestore database.
                    final controller = ScreenshotController();
                    final bytes = await controller.captureFromWidget(
                      _buildTemplate(widget.imagePath, width, height)
                    );

                    String uuid = const Uuid().v1();
                    await storage.uploadBytes(bytes, uuid);
                    var imageString = await storage.getDownloadURL(uuid);

                    FirebaseFirestore.instance.collection("card").add({
                      "cardImage" : imageString,
                    }).then((value) {
                      Fluttertoast.showToast(msg: "Successfully created");
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const MakeInvitation()
                      ));
                    }).catchError((error){
                      Fluttertoast.showToast(msg: "Fail to create invitation card");
                    });
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTemplate(String imagePath, double width, double height) {

    if (imagePath == "card1.png") {
      return buildTemplate1(
      width: width, 
      height: height, 
      name1: groomNameController.text,
      name2: brideNameController.text,
      location: locationController.text,
      date: dateController.text,
      time: timeController.text);
    } 
    else if (imagePath == "card2.png") {
      return buildTemplate2(
      width: width, 
      height: height, 
      name1: groomNameController.text,
      name2: brideNameController.text,
      location: locationController.text,
      date: dateController.text,
      time: timeController.text);
    } 
    else if (imagePath == "card3.png") {
      return buildTemplate3(
      width: width, 
      height: height, 
      name1: groomNameController.text,
      name2: brideNameController.text,
      location: locationController.text,
      date: dateController.text,
      time: timeController.text);
    } 
    else {
      return buildTemplate4(
      width: width, 
      height: height, 
      name1: groomNameController.text,
      name2: brideNameController.text,
      location: locationController.text,
      date: dateController.text,
      time: timeController.text);
    }
  }
}