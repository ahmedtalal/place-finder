import 'package:flutter/material.dart';

class CartModel {
  String itemId, itemCartId;
  String itemImage;
  String itemName;
  double price;
  double newPrice;
  int quantity;

  CartModel({
    @required this.itemId,
    @required this.itemImage,
    @required this.itemName,
    @required this.itemCartId,
    @required this.price,
    @required this.newPrice,
    @required this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> data) {
    this.itemId = data["itemId"];
    this.itemName = data["itemName"];
    this.itemImage = data["itemImage"];
    this.itemCartId = data["itemCartId"];
    this.price = data["price"];
    this.price = data["newPrice"];
    this.quantity = data["quantity"];
  }

  static Map<String, dynamic> toJson(CartModel model) => {
        "itemId": model.itemId,
        "itemName": model.itemName,
        "itemImage": model.itemImage,
        "itemCartId": model.itemCartId,
        "price": model.price,
        "newPrice": model.newPrice,
        "quantity": model.quantity,
      };
}
