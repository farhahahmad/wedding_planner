// This code defines a VendorModel class with properties representing vendor information

class VendorsModel {
  String? id;
  String? name;
  String? description;
  double? price;
  String? location;
  String? category;
  String? image;
  String? email;
  String? phone;

  VendorsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.location,
    required this.category,
    required this.image,
    required this.email,
    required this.phone
  });
}