import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  String message;
  var onClick;
  var onValidate;
  IconData icon;
  TextEditingController textEditingController;
  TextInputWidget({
    @required this.message,
    @required this.icon,
    @required this.onClick,
    @required this.onValidate,
    @required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: message == "Email" ? false : true,
      controller: textEditingController,
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
          fontSize: 9.0,
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
