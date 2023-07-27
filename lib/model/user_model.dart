// This code defines a UserModel class with properties representing user information and methods

class UserModel {
  String? uid;
  String? email;
  String? userName;
  bool? supplier;

  UserModel({this.uid, this.email, this.userName, this.supplier});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      supplier: map['supplier'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'supplier' : supplier
    };
  }
}