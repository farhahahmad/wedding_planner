// This code displays details of a vendor

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wedding_planner/model/vendors_model.dart';
import 'package:wedding_planner/view/vendors_category.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorsDetails extends StatefulWidget {

  final VendorsModel vendors;
  const VendorsDetails({super.key, required this.vendors});

  @override
  State<VendorsDetails> createState() => _VendorsDetailsState();
}

class _VendorsDetailsState extends State<VendorsDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.vendors.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.vendors.location!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: NetworkImage(widget.vendors.image!),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Vendor Details",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.vendors.description!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: HexColor("#F3F3F3"),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  leading: const Icon(Icons.sell),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Starting price",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "RM ${widget.vendors.price!.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                            ],
                  ),
                )
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // send email by launching the email app
                  Column(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: HexColor("#C0ABAF"),
                          child: const Icon(Icons.email_outlined, color: Colors.white),
                        ),
                        onTap: () async {
                          final url = Uri.parse('mailto:${widget.vendors.email!}?subject=Email&body=email');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("Send Email", style: TextStyle(fontSize: 15))
                    ],
                  ),
                  // call phone by launching the phone call
                  Column(
                    children: [
                      GestureDetector(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: HexColor("#C0ABAF"),
                          child: const Icon(Icons.call_end_outlined, color: Colors.white),
                        ),
                        onTap: () async {
                          final url = Uri.parse('tel:${widget.vendors.phone!}');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text("Call phone", style: TextStyle(fontSize: 15))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "Venues",
        style: TextStyle(color: Colors.black, fontSize: 17),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white,
      shape: const Border(
          bottom: BorderSide(
          color: Color.fromARGB(255, 218, 218, 218),
          width: 1
        )
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          if(widget.vendors.category == "venues") {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const VendorsCategory(category: "venues")
            ));
          } else if(widget.vendors.category == "catering") {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const VendorsCategory(category: "catering")
            ));
          } else if(widget.vendors.category == "bridal") {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const VendorsCategory(category: "bridal")
            ));
          } else if(widget.vendors.category == "photographer") {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const VendorsCategory(category: "photographer")
            ));
          } else {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => const VendorsCategory(category: "makeup")
            ));
          }
          
        }
      ),
    );
  }
}