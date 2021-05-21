import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class SliderWidget extends StatelessWidget {
  String image, title, description;
  SliderWidget({
    @required this.image,
    @required this.title,
    @required this.description,
  });
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(image),
            height: height * 0.38,
          ),
          SizedBox(
            height: height * 0.045,
          ),
          Container(
            width: width * 0.8,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: appFont,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Container(
            width: width * 0.8,
            child: Text(
              description,
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: appFont,
                color: Colors.black45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
