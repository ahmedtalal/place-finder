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

    return Container(
      height: height * 0.2,
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
              return Card(
                elevation: 3.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: height * 0.15,
                      width: 90.0,
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image(
                          image: AssetImage(userImage),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: appFont,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data["message"],
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
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
