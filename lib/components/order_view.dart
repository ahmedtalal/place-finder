import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class OrderView extends StatelessWidget {
  var orderData;
  OrderView({
    @required this.orderData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Quantity : ",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: appFont,
                    ),
                  ),
                  Text(
                    orderData["numOfQuantity"].toString(),
                    style: TextStyle(
                      fontFamily: appFont,
                      fontSize: 16.0,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Text(
                orderData["oderTime"],
                style: TextStyle(
                  fontFamily: appFont,
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Text(
                "Total Price :",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: appFont,
                ),
              ),
              Text(
                orderData["totalPrice"].toString(),
                style: TextStyle(
                  fontFamily: appFont,
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Order Details :",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: appFont,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "more",
                      style: TextStyle(
                        fontFamily: appFont,
                        fontSize: 16.0,
                        color: Colors.redAccent,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.double,
                        decorationColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.check,
                size: 16.0,
                color: Colors.green,
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
