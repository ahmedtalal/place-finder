import 'package:flutter/material.dart';

class TargetModel {
  String name,
      id,
      description,
      locationDetails,
      location,
      image,
      placePhone,
      type;
  double price, rating;
  int numOfRooms, offer;
  List<dynamic> reservationList;

  TargetModel({
    @required this.name,
    @required this.type,
    @required this.id,
    @required this.description,
    @required this.location,
    @required this.locationDetails,
    @required this.image,
    @required this.numOfRooms,
    @required this.price,
    @required this.rating,
    @required this.offer,
    @required this.reservationList,
    @required this.placePhone,
  });

  TargetModel.obj2({
    @required this.id,
    @required this.type,
  });

  TargetModel.fromJson(Map<String, dynamic> data) {
    this.name = data["name"];
    this.type = data["type"];
    this.id = data["id"];
    this.description = data["description"];
    this.location = data["location"];
    this.locationDetails = data["locationDetails"];
    this.image = data["image"];
    this.numOfRooms = data["numOfRooms"];
    this.price = data["price"];
    this.rating = data["rating"];
    this.offer = data["offer"];
    this.reservationList = data["reservationList"];
    this.placePhone = data["placephone"];
  }

  static Map<String, dynamic> toJson(TargetModel model) => {
        "name": model.name,
        "type": model.type,
        "id": model.id,
        "description": model.description,
        "location": model.location,
        "locationDetails": model.locationDetails,
        "image": model.image,
        "numOfRooms": model.numOfRooms,
        "price": model.price,
        "rating": model.rating,
        "offer": model.offer,
        "reservationList": model.reservationList,
        "placephone": model.placePhone,
      };
}
