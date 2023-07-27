import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ProductController extends ControllerMVC {

  factory ProductController() {
    _this ??= ProductController._();
    return _this!;
  }
  static ProductController? _this;
  ProductController._();

  void addProduct(String name, String description, double price, int quantity, String packing, String image) {
    FirebaseFirestore.instance.collection("products").add({
      "name" : name,
      "description" : description,
      "price" : price,
      "quantity" : quantity,
      "packing" : packing,
      "image" : image
    }).then((value) {
      Fluttertoast.showToast(msg: "Successfully add product");
    }).catchError((error){
      Fluttertoast.showToast(msg: "Add product failed");
    });
  }

  void updateProduct(String id, String name, String description, double price, int quantity, String packing, String image) {
    FirebaseFirestore.instance.collection("products").doc(id).update({
      "name" : name,
      "description" : description,
      "price" : price,
      "quantity" : quantity,
      "packing" : packing,
      "image" : image
    }).then((value) {
      Fluttertoast.showToast(msg: "Successfully update");
    }).catchError((error){
      Fluttertoast.showToast(msg: "Update failed");
    });
  }
}