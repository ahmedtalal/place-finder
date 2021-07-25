import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/dashboard/modify_item.dart';
import 'package:online_booking_places/pages/reviews.dart';
import 'package:rating_bar/rating_bar.dart';

// ignore: must_be_immutable
class ItemInfoDetailsAmin extends StatefulWidget {
  Map<String, dynamic> item;
  ItemInfoDetailsAmin({
    @required this.item,
  });
  @override
  _ItemInfoDetailsAminState createState() => _ItemInfoDetailsAminState();
}

class _ItemInfoDetailsAminState extends State<ItemInfoDetailsAmin> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.056,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionWidget(
                    onClick: () {
                      Navigator.of(context).pop(context);
                    },
                    icon: Icons.arrow_back_ios_rounded,
                  ),
                  Row(
                    children: [
                      ActionWidget(
                        onClick: () {
                          String message =
                              "this is restaurant from our app :>> " +
                                  widget.item["name"];
                          shared(message, context);
                        },
                        icon: Icons.share,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      ActionWidget(
                        onClick: () {},
                        icon: Icons.favorite_border,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.033,
              ),
              Container(
                height: height * 0.24,
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: widget.item["image"],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image(
                    image: AssetImage(emptyData),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.item["name"],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: appFont,
                            color: Colors.black,
                          ),
                        ),
                        RatingBar.readOnly(
                          initialRating: widget.item["rating"],
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: appFont,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        widget.item["description"],
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: appFont,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: width * 0.5,
                      child: Center(
                        child: Divider(
                          thickness: 1.0,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_history,
                          size: 15.0,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                          width: width * 0.8,
                          child: Text(
                            widget.item["locationDetails"],
                            style: TextStyle(
                              fontSize: 12.0,
                              fontFamily: appFont,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 15.0,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.item["location"],
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: appFont,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.group,
                          size: 15.0,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.item["numOfRooms"].toString() + " person",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: appFont,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.price_check,
                          size: 15.0,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.item["price"].toString() + " LE per person",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: appFont,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 15.0,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.item["offer"].toString() + " % discount",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: appFont,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 15.0,
                          color: Colors.grey[600],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          widget.item["placephone"],
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: appFont,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            print(widget.item["id"]);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (c) => ReviewsPage(
                                  itemId: widget.item["id"],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: width * 0.4,
                            height: height * 0.063,
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                "Reviews",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: appFont,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (C) => ModifyItem(
                                  itemData: widget.item,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: width * 0.4,
                            height: height * 0.063,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                "Modify",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: appFont,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
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
