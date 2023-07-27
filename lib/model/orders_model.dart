// This code defines a OrdersModel class with properties representing order information

class OrdersModel {
  String? id;
  String? userid;
  String? fullname;
  String? phone;
  String? address;
  double? subtotal;
  double? total;
  String? payment;
  String? delivery;
  String? status;

  OrdersModel({
    required this.id,
    required this.userid,
    required this.fullname,
    required this.phone,
    required this.address,
    required this.subtotal,
    required this.total,
    required this.payment,
    required this.delivery,
    required this.status
  });
}