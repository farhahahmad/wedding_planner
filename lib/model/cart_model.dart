// This code defines a CartModel class with properties representing cart information

class CartModel {
  String? id;
  String? userid;
  String? productid;
  String? image;
  String? name;
  double? price;
  int? quantity;
  double? total;

  CartModel({
    required this.id,
    required this.userid,
    required this.productid,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.total
  });
}