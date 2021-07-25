import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/favorite_bloc/favorite_bloc.dart';
import 'package:online_booking_places/bloc_services/favorite_bloc/favorite_events.dart';
import 'package:online_booking_places/bloc_services/favorite_bloc/favorite_states.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_events.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_states.dart';
import 'package:online_booking_places/components/favorite_view.dart';
import 'package:online_booking_places/components/item_view.dart';
import 'package:online_booking_places/constants.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var userProvider = BlocProvider.of<UserBloc>(context);
    userProvider.model = FirebaseAuth.instance.currentUser.uid;
    userProvider.add(GetUserEvent());
    var favProivder = BlocProvider.of<FavoriteBloc>(context);
    favProivder.add(FetchFavItemsEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Favorite",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: appFont,
                    ),
                  ),
                  BlocBuilder<UserBloc, UserStates>(
                    builder: (context, state) {
                      if (state is UserLoadingState) {
                        return CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.blue[50],
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UserLoadedState) {
                        return StreamBuilder<DocumentSnapshot>(
                          stream: state.response,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.blue[50],
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ClipOval(
                                child: CachedNetworkImage(
                                  height: 30.0,
                                  fit: BoxFit.cover,
                                  imageUrl: snapshot.data["image"],
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Image(
                                    image: AssetImage(userImage),
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      } else {
                        return CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.blue[50],
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              BlocBuilder<FavoriteBloc, FavoriteStates>(
                builder: (context, state) {
                  var result;
                  if (state is FavItemsLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FavItemsLoadedState) {
                    result = state.reposnse;
                  } else if (state is FavItemsErrorState) {
                    return Center(
                      child: Container(
                        height: height * 0.5,
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage(emptyData),
                              height: height * 0.3,
                            ),
                            Text(
                              "No data at this time",
                              style: TextStyle(
                                fontFamily: appFont,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return StreamBuilder<QuerySnapshot>(
                    stream: result,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        List items = [];
                        snapshot.data.docs.forEach((DocumentSnapshot element) {
                          items.add(element.data());
                        });
                        print(items);
                        return Expanded(
                          child: FavoriteView(
                            items: items,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
