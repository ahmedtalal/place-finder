import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_bloc.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_events.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_states.dart';
import 'package:online_booking_places/components/item_view.dart';
import 'package:online_booking_places/constants.dart';

class Targets extends StatefulWidget {
  @override
  _TargetsState createState() => _TargetsState();
}

class _TargetsState extends State<Targets> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var userProvider = BlocProvider.of<UserBloc>(context);
    userProvider.model = FirebaseAuth.instance.currentUser.uid;
    userProvider.add(GetUserEvent());
    var itemProvider = BlocProvider.of<ItemBloc>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
            height * 0.22,
          ),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: height * 0.1,
            elevation: 0.2,
            title: Row(
              children: [
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
                                height: 35.0,
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
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontFamily: appFont,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart,
                  size: 20.0,
                  color: Colors.red,
                ),
              ),
            ],
            bottom: TabBar(
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.red[400],
              ),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: Colors.red[400],
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Restaurants",
                        style: TextStyle(
                          fontFamily: appFont,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: Colors.red[400],
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Cinemas",
                        style: TextStyle(
                          fontFamily: appFont,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                        color: Colors.red[400],
                        width: 1,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Hotels",
                        style: TextStyle(
                          fontFamily: appFont,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Restaurants",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: appFont,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                BlocBuilder<ItemBloc, ItemStates>(
                  builder: (context, state) {
                    itemProvider.model = "Rastaurants";
                    itemProvider.add(FetchItemsEvent());
                    var result;
                    if (state is ItemsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ItemsLoadedState) {
                      result = state.response;
                    } else if (state is ItemsFailedState) {
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
                          snapshot.data.docs
                              .forEach((DocumentSnapshot element) {
                            items.add(element.data());
                          });
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return ItemView(
                                  targetMap: items[index],
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cinemas",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: appFont,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                BlocBuilder<ItemBloc, ItemStates>(
                  builder: (context, state) {
                    itemProvider.model = "Cinema";
                    itemProvider.add(FetchItemsEvent());
                    var result;
                    if (state is ItemsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ItemsLoadedState) {
                      result = state.response;
                    } else if (state is ItemsFailedState) {
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
                                "No posts at this time",
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
                          snapshot.data.docs
                              .forEach((DocumentSnapshot element) {
                            items.add(element.data());
                          });
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return ItemView(
                                  targetMap: items[index],
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hotels",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: appFont,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                BlocBuilder<ItemBloc, ItemStates>(
                  builder: (context, state) {
                    itemProvider.model = "Hotels";
                    itemProvider.add(FetchItemsEvent());
                    var result;
                    if (state is ItemsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ItemsLoadedState) {
                      result = state.response;
                    } else if (state is ItemsFailedState) {
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
                                "No posts at this time",
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
                          snapshot.data.docs
                              .forEach((DocumentSnapshot element) {
                            items.add(element.data());
                          });
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                return ItemView(
                                  targetMap: items[index],
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
