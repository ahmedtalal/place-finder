import 'package:flutter/material.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/constants.dart';

class OldOrders extends StatefulWidget {
  @override
  _OldOrdersState createState() => _OldOrdersState();
}

class _OldOrdersState extends State<OldOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  ActionWidget(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icons.arrow_back_ios,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "Completed Orders",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: appFont,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
