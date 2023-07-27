import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class VendorController extends ControllerMVC {

  factory VendorController() {
    _this ??= VendorController._();
    return _this!;
  }
  static VendorController? _this;
  VendorController._();

  void addVendor(String name, String description, double price, String location, String category, String image, String email, String phone) {
    FirebaseFirestore.instance.collection("vendors").add({
      "name" : name,
      "description" : description,
      "price" : price,
      "location" : location,
      "category" : category,
      "image" : image,
      "email" : email,
      "phone" : phone
    }).then((value) {
      Fluttertoast.showToast(msg: "Successfully add vendor");
    }).catchError((error){
      Fluttertoast.showToast(msg: "Add vendor failed");
    });
  }

  void updateVendor(String id, String name, String description, double price, String location, String category, String image, String email, String phone){
    FirebaseFirestore.instance.collection("vendors").doc(id).update({
      "name" : name,
      "description" : description,
      "price" : price,
      "location" : location,
      "category" : category,
      "image" : image,
      "email" : email,
      "phone" : phone
    }).then((value) {
      Fluttertoast.showToast(msg: "Successfully update");
    }).catchError((error){
      Fluttertoast.showToast(msg: "Update failed");
    });
  }
}