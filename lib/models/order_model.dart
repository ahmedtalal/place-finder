import 'package:flutter/material.dart';
import 'package:online_booking_places/models/cart_model.dart';

class OrderModel {
  String orderId, orderTime;
  double totalPrice;
  int numOfQuantity;
  List<CartModel> orderDetails;
  bool checked;

  OrderModel({
    @required this.orderId,
    @required this.totalPrice,
    @required this.numOfQuantity,
    @required this.orderTime,
    @required this.orderDetails,
    @required this.checked,
  });
  OrderModel.fromJson(Map<String, dynamic> data) {
    this.orderId = data["orderId"];
    this.totalPrice = data["totalPrice"];
    this.numOfQuantity = data["numOfQuantity"];
    this.orderTime = data["oderTime"];
    this.orderDetails = data["orderDetails"];
    this.checked = data["checked"];
  }

  static Map<String, dynamic> toJson(OrderModel model) => {
        "orderId": model.orderId,
        "totalPrice": model.totalPrice,
        "numOfQuantity": model.numOfQuantity,
        "orderTime": model.orderTime,
        "orderDetails": model.orderDetails,
        "checked": model.checked,
      };
}
