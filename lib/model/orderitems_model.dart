// This code defines a OrderitemsModel class with properties representing order items information

class OrderitemsModel {
  String? id;
  String? orderid;
  String? userid;
  String? productid;
  String? image;
  String? name;
  double? price;
  int? quantity;
  double? total;

  OrderitemsModel({
    required this.id,
    required this.orderid,
    required this.userid,
    required this.productid,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
    required this.total
  });
}