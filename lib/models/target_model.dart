import 'package:flutter/material.dart';

class TargetModel {
  String name, id, description, locationDetails, location, image, phone;
  double price, rating;
  int numOfRoomes;
  List<String> reservationList;

  TargetModel({
    @required this.name,
    @required this.id,
    @required this.description,
    @required this.location,
    @required this.locationDetails,
    @required this.image,
    @required this.numOfRoomes,
    @required this.price,
    @required this.rating,
    @required this.reservationList,
    @required this.phone,
  });

  TargetModel.fromJson(Map<String, dynamic> data) {
    this.name = data["name"];
    this.id = data["id"];
    this.description = data["description"];
    this.location = data["location"];
    this.locationDetails = data["locationDetails"];
    this.image = data["image"];
    this.numOfRoomes = data["numOfRoomes"];
    this.price = data["price"];
    this.rating = data["rating"];
    this.reservationList = data["reservationList"];
    this.phone = data["phone"];
  }

  static Map<String, dynamic> toJson(TargetModel model) => {
        "name": model.name,
        "id": model.id,
        "description": model.description,
        "location": model.location,
        "locationDetails": model.locationDetails,
        "image": model.image,
        "numOfRoomes": model.numOfRoomes,
        "price": model.price,
        "rating": model.rating,
        "reservationList": model.reservationList,
        "phone": model.phone,
      };
}
