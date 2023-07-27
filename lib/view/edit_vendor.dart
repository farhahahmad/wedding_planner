// This code allows supplier to edit the details of a specific vendor

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:wedding_planner/controller/vendor_controller.dart';
import 'package:wedding_planner/model/vendors_model.dart';
import 'package:wedding_planner/view/registered_supplier_menu.dart';
import 'package:wedding_planner/view/supplier_vendors.dart';
import 'package:wedding_planner/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class EditVendor extends StatefulWidget {

  final VendorsModel vendors;
  const EditVendor({super.key, required this.vendors});
   
  @override
  State<EditVendor> createState() => _EditVendorState();
}

class _EditVendorState extends State<EditVendor> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final VendorController _con = VendorController();

  late final TextEditingController nameController = TextEditingController(text: widget.vendors.name);
  late final TextEditingController emailController = TextEditingController(text: widget.vendors.email);
  late final TextEditingController phoneController = TextEditingController(text: widget.vendors.phone);
  late final TextEditingController descController = TextEditingController(text: widget.vendors.description);
  late final TextEditingController priceController = TextEditingController(text: widget.vendors.price.toString());
  late final TextEditingController locationController = TextEditingController(text: widget.vendors.location);
  late final TextEditingController imageController = TextEditingController(text: widget.vendors.image);
  late String measure = widget.vendors.category!;
  StorageService storage = StorageService();
  String imageString = "Upload product image";

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: const Text(
          "Update Vendor",
          style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const RegisteredSupplierMenu()
              ));
            }
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Vendor Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Vendor Name',
                    labelStyle: TextStyle(fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    border: OutlineInputBorder()),
                  controller: nameController,
                  onSaved: (value) {
                    nameController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  controller: descController,
                  onSaved: (value) {
                    descController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
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
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
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
                  onSaved: (value) {
                    phoneController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Starting Price',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  controller: priceController,
                  onSaved: (value) {
                    priceController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Location',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  controller: locationController,
                  onSaved: (value) {
                    locationController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(
                      value: "venues",
                      child: Text("Venues", style: TextStyle(fontSize: 15)),
                    ),
                    DropdownMenuItem(
                      value: "catering",
                      child: Text("Catering", style: TextStyle(fontSize: 15)),
                    ),
                    DropdownMenuItem(
                      value: "bridal",
                      child: Text("Bridal Wear", style: TextStyle(fontSize: 15)),
                    ),
                    DropdownMenuItem(
                      value: "photographer",
                      child: Text("Photographer", style: TextStyle(fontSize: 15)),
                    ),
                    DropdownMenuItem(
                      value: "makeup",
                      child: Text("Makeup", style: TextStyle(fontSize: 15)),
                    ),
                  ],
                  hint: const Text("Vendor Category", style: TextStyle(fontSize: 15)),
                  onChanged: (value) {
                      setState(() {
                        measure = value!;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        measure = value!;
                      });
                    }
                ),
                const SizedBox(height: 30),

                // Upload an image for the vendor
                DottedBorder(
                  color: HexColor("#AB9397"),
                  strokeWidth: 1, 
                  dashPattern: const [10,6], 
                  child: GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            color: HexColor("#AB9397"),
                          ),
                          const SizedBox(height: 10),
                          const Text("Upload vendor image", style: TextStyle(fontSize: 15),)
                        ],
                      ),
                    ),
                    onTap: () async {
                      ImagePicker picker = ImagePicker();
                      final XFile? image0 = await picker.pickImage(
                        source: ImageSource.gallery);
    
                      if (image0 == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No image was selected'),
                          ),
                        );
                      }
    
                      if(image0 != null) {
                        await storage.uploadImage(image0);
                        var image = await storage.getDownloadURL(image0.name);
                        imageController.text = image;
                        setState(() {
                          imageString = image0.name;
                        });
                      }
                    },
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
                      backgroundColor: HexColor("#91777C")
                    ),
                    child: const Text('Update Vendor', style: TextStyle(fontSize: 15),),
                    onPressed: () {

                      // The vendor information is sent to the VendorController to be updated to the database
                      _con.updateVendor(
                        widget.vendors.id!,
                        nameController.text, 
                        descController.text, 
                        double.parse(priceController.text),
                        locationController.text,
                        measure,
                        imageController.text,
                        emailController.text,
                        phoneController.text);

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const SupplierVendors()
                      ));
                    },
                  )
                ),
              ],
            ),
          ),
              ),
        ),
      );
   }
}