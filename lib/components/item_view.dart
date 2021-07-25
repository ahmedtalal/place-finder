import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/navbar_components/item_info_details.dart';
import 'package:online_booking_places/pages/navbar_components/item_info_details_admin.dart';
import 'package:rating_bar/rating_bar.dart';

// ignore: must_be_immutable
class ItemView extends StatelessWidget {
  Map<String, dynamic> targetMap;
  ItemView({@required this.targetMap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (FirebaseAuth.instance.currentUser.email == "admin@gmail.com") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => ItemInfoDetailsAmin(
                item: targetMap,
              ),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (c) => ItemInfoDetails(
                item: targetMap,
              ),
            ),
          );
        }
      },
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.0,
                width: 90.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  height: 95.0,
                  width: 90.0,
                  fit: BoxFit.fill,
                  imageUrl: targetMap["image"],
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Image(
                    image: AssetImage(emptyData),
                  ),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey[400],
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              targetMap["name"],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: appFont,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          targetMap["offer"] == 0
                              ? ""
                              : "${targetMap["offer"]}%",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: appFont,
                            color: targetMap["offer"] != 0
                                ? Colors.blue[200]
                                : null,
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
                          Icons.price_check,
                          color: Colors.grey[400],
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          targetMap["price"].toString() + " LE  per person",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: appFont,
                            color: Colors.black54,
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
                          Icons.group,
                          color: Colors.grey[400],
                          size: 16.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          targetMap["numOfRooms"].toString() + " person",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: appFont,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey[400],
                              size: 16.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              targetMap["location"],
                              style: TextStyle(
                                fontSize: 13.0,
                                fontFamily: appFont,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 5.0,
                        ),
                        RatingBar.readOnly(
                          initialRating: targetMap["rating"],
                          filledIcon: Icons.favorite,
                          emptyIcon: Icons.favorite_border,
                          halfFilledIcon: Icons.favorite_border,
                          isHalfAllowed: true,
                          filledColor: Colors.amberAccent,
                          emptyColor: Colors.grey,
                          halfFilledColor: Colors.amberAccent,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
