// This code allows supplier to edit the details of a specific product 

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:wedding_planner/controller/product_controller.dart';
import 'package:wedding_planner/model/products_model.dart';
import 'package:wedding_planner/view/registered_supplier_menu.dart';
import 'package:wedding_planner/view/supplier_products.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wedding_planner/services/storage_service.dart';

class EditProduct extends StatefulWidget {

  final ProductsModel products;
  const EditProduct({super.key, required this.products});
   
  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final ProductController _con = ProductController();

  late final TextEditingController nameController = TextEditingController(text: widget.products.name);
  late final TextEditingController descController = TextEditingController(text: widget.products.description);
  late final TextEditingController priceController = TextEditingController(text: widget.products.price.toString());
  late final TextEditingController quantityController = TextEditingController(text: widget.products.quantity.toString());
  late final TextEditingController packingController = TextEditingController(text: widget.products.packing);
  late final TextEditingController imageController = TextEditingController(text: widget.products.image);

  StorageService storage = StorageService();
  String imageString = "Update product image";

   @override
    Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
         title: const Text(
          "Update Product",
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
                    "Product Information",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Product Name',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  controller: nameController,
                  onSaved: (value) {
                    if (value!.isEmpty) {
                      nameController.text = widget.products.name!;
                    } else {
                      nameController.text = value;
                    }
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
                    if (value!.isEmpty) {
                      descController.text = widget.products.description!;
                    } else {
                      descController.text = value;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Price',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  controller: priceController,
                  onSaved: (value) {
                    if (value!.isEmpty) {
                      priceController.text = widget.products.price!.toString();
                    } else {
                      priceController.text = value;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Quantity',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  controller: quantityController,
                  onSaved: (value) {
                    if (value!.isEmpty) {
                      quantityController.text = widget.products.quantity!.toString();
                    } else {
                      quantityController.text = value;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Packing Size',
                      labelStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      border: OutlineInputBorder()),
                  controller: packingController,
                  onSaved: (value) {
                    if (value!.isEmpty) {
                      packingController.text = widget.products.packing!;
                    } else {
                      packingController.text = value;
                    }
                  },
                  textInputAction: TextInputAction.next,
                ),
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
                        imageController.text = widget.products.image!;
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
              backgroundColor: HexColor("#91777C")
            ),
            child: const Text('Update Product', style: TextStyle(fontSize: 15),),
            onPressed: () {

              // The product information is sent to the ProductController to be updated to the database
              _con.updateProduct(
                widget.products.id!,
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
}