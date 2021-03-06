import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class SettingComponentsView extends StatelessWidget {
  Function onClick;
  String hint;
  String icon;
  Color color;
  SettingComponentsView({
    @required this.onClick,
    @required this.hint,
    @required this.icon,
    @required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15.0,
                backgroundColor: color,
                child: Image(
                  image: AssetImage(icon),
                  height: 14.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: appFont,
                  color: hint == "LogOut" ? Colors.purple : null,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 15.0,
          ),
        ],
      ),
    );
  }
}
