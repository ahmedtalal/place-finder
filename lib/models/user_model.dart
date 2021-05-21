import 'package:flutter/material.dart';

class UserModel {
  String name, email, password, id, image, phoneNumber;

  UserModel({
    @required this.name,
    @required this.email,
    @required this.id,
    @required this.image,
    @required this.phoneNumber,
  });
  UserModel.loginModel({
    @required this.email,
    @required this.password,
  });

  UserModel.registerModel({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.phoneNumber,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    this.id = data["id"];
    this.name = data["name"];
    this.email = data["email"];
    this.image = data["image"];
    this.phoneNumber = data["phoneNumber"];
  }

  static Map<String, dynamic> toJson(UserModel user) => {
        "id": user.id,
        "name": user.name,
        "email": user.email,
        "image": user.image,
        "phoneNumber": user.phoneNumber,
      };
}
