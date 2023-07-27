// This code creates a functional user interface that allows registered suppliers to add new products to their inventory

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:wedding_planner/controller/product_controller.dart';
import 'package:wedding_planner/view/registered_supplier_menu.dart';
import 'package:wedding_planner/view/supplier_products.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_planner/services/storage_service.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

   
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  final ProductController _con = ProductController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  StorageService storage = StorageService();
  String imageString = "Upload product image";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController packingController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Product Information",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                const SizedBox(height: 20),
                addTextFormField("Product Name", nameController, "Please enter product name"),
                const SizedBox(height: 20),
                addTextFormField("Description", descController, "Please enter description"),
                const SizedBox(height: 20),
                addTextFormField("Price", priceController, "Please enter price"),
                const SizedBox(height: 20),
                addTextFormField("Quantity", quantityController, "Please enter quantity"),
                const SizedBox(height: 20),
                addTextFormField("Packing Size", packingController, "Please enter packing size"),
                const SizedBox(height: 30),
                
                // Upload an image for the product
                DottedBorder(
                  color: HexColor("#91777C"),
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
                            color: HexColor("#91777C"),
                          ),
                          const SizedBox(height: 10),
                          Text(imageString, style: const TextStyle(fontSize: 15),)
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
                )
              ],
            ),
          ),
              ),
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
              backgroundColor: HexColor("#C0ABAF")
            ),
            child: const Text('Add Product', style: TextStyle(fontSize: 15),),
            onPressed: () {
              // The product information is sent to the ProductController to be added to the database
              _con.addProduct(
                nameController.text, 
                descController.text, 
                double.parse(priceController.text),
                int.parse(quantityController.text),
                packingController.text,
                imageController.text);

              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const SupplierProducts()
              ));
            },
          )
        ),
      );
   }

  // text form fields to input product information
  TextFormField addTextFormField(String labelText, TextEditingController controller, String warningText) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 15),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide:
              BorderSide(color: Colors.grey, width: 1.0),
        ),
        border: const OutlineInputBorder()),
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return (warningText);
        }
        return null;
      },
      onSaved: (value) {
        controller.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
   }


  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        "Add Product",
        style: TextStyle(color: Colors.black, fontSize: 17),
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
            builder: (context) => const RegisteredSupplierMenu()
          ));
        }
      ),
    );
  }
}