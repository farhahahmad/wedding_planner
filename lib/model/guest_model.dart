// This code defines a GuestModel class with properties representing guest information

class GuestModel {
  String? id;
  String? name;
  String? address;
  bool isDone;

  GuestModel({
    required this.id,
    required this.name,
    required this.address,
    this.isDone = false,
  });
}