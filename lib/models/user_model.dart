import 'package:flutter/material.dart';

class UserModel {
  String name, email, password, id, image;

  UserModel({
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.id,
    @required this.image,
  });

  UserModel.fromJson(Map<String,dynamic> data){
    this.id = data["id"] ;
    this.name = data["name"];
    this.email = data["email"] ;
    this.image = data["image"] ;
  }

  static Map<String,dynamic> toJson(UserModel user)=>{
    "id":user.id ,
    "name":user.name ,
    "email":user.email,
    "image":user.image,
  };

}
