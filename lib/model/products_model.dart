// This code defines a ProductModel class with properties representing product information

class ProductsModel {
  String? id;
  String? name;
  String? description;
  double? price;
  int? quantity;
  String? packing;
  String? image;

  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.packing,
    required this.image
  });
}

