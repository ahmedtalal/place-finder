import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class DashBoardBody extends StatelessWidget {
  var onClick;
  String title;
  String icon;
  DashBoardBody({
    @required this.title,
    @required this.icon,
    @required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 6.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 24.0,
              backgroundColor: Colors.blue[100],
              child: Image(
                image: AssetImage(
                  icon,
                ),
                height: 30.0,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: appFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
