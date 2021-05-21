import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class UserViewAdapter extends StatelessWidget {
  String image, name, email, phone;
  UserViewAdapter({
    @required this.name,
    @required this.email,
    @required this.phone,
    @required this.image,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.16,
      child: Card(
        margin: EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 10.0,
          right: 10.0,
        ),
        elevation: 4.0,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 57.0,
                width: 57.0,
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 17.0,
                    child: Image(
                      image: AssetImage(image),
                      height: 32.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 14.0,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: appFont,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 12.0,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: appFont,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.0,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 12.0,
                      color: Colors.grey[500],
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      phone,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontFamily: appFont,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
