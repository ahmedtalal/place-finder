import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class TextInputWidgetNoController extends StatelessWidget {
  String message;
  var onClick;
  var onValidate;
  IconData icon;
  TextInputWidgetNoController({
    @required this.message,
    @required this.icon,
    @required this.onClick,
    @required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: message == "description" || message == "message" ? 8 : 1,
      enabled: message == "Email" ? false : true,
      style: TextStyle(
        fontSize: 10.0,
        fontFamily: appFont,
      ),
      onChanged: onClick,
      validator: onValidate,
      decoration: InputDecoration(
        labelText: message,
        prefixIcon: Icon(
          icon,
          color: Colors.black54,
          size: 15.0,
        ),
        labelStyle: TextStyle(
          fontFamily: appFont,
          color: Colors.grey[500],
          fontSize: 10.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.4,
          ),
        ),
      ),
      obscureText: message.toLowerCase() == "password" ? true : false,
      keyboardType: message.toLowerCase() == "name"
          ? TextInputType.text
          : TextInputType.emailAddress,
    );
  }
}
