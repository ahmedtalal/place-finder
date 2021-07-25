import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_events.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_states.dart';
import 'package:online_booking_places/constants.dart';
import 'package:rating_bar/rating_bar.dart';

// ignore: must_be_immutable
class ReviewsView extends StatelessWidget {
  Map<String, dynamic> data;
  ReviewsView({
    @required this.data,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var userProvider = BlocProvider.of<UserBloc>(context);
    userProvider.model = data["userId"];
    userProvider.add(GetUserEvent());

    return Card(
      elevation: 5.0,
      child: BlocBuilder<UserBloc, UserStates>(
        builder: (context, state) {
          var result;
          if (state is UserLoadedState) {
            result = state.response;
          }
          return StreamBuilder<DocumentSnapshot>(
            stream: result,
            builder: (context, snapshot) {
              String name, image;
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                name = snapshot.data["name"];
                image = snapshot.data["image"];
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500.0),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            imageUrl: image,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image(
                              image: AssetImage(userImage),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: appFont,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      left: 12.0,
                      right: 12.0,
                      bottom: 8.0,
                    ),
                    child: Text(
                      data["message"],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: appFont,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  RatingBar.readOnly(
                    initialRating: data["rating"],
                    filledIcon: Icons.favorite,
                    emptyIcon: Icons.favorite_border,
                    halfFilledIcon: Icons.favorite_border,
                    isHalfAllowed: true,
                    filledColor: Colors.amberAccent,
                    emptyColor: Colors.grey,
                    halfFilledColor: Colors.amberAccent,
                    size: 18.0,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
