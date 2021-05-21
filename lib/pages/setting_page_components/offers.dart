import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/item_view.dart';
import 'package:online_booking_places/models/target_model.dart';

import '../../constants.dart';

class Offers extends StatefulWidget {
  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  bool restauranttChecked = true;
  bool cimenaChecked = false;
  bool hotelChecked = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var offerProvider = BlocProvider.of<ItemBloc>(context);
    if (restauranttChecked == true) {
      offerProvider.model = "Rastaurants";
      offerProvider.add(FetchOffersEvent());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            10.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.026,
              ),
              Row(
                children: [
                  ActionWidget(
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icons.arrow_back_ios,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Offers",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: appFont,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        restauranttChecked = true;
                        cimenaChecked = false;
                        hotelChecked = false;
                      });
                      offerProvider.model = "Rastaurants";
                      offerProvider.add(FetchOffersEvent());
                    },
                    child: Container(
                      height: 90,
                      width: 100,
                      decoration: BoxDecoration(
                        color: restauranttChecked == true
                            ? Colors.red[300]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Restaurants",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: appFont,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        restauranttChecked = false;
                        cimenaChecked = true;
                        hotelChecked = false;
                      });
                      offerProvider.model = "Cinema";
                      offerProvider.add(FetchOffersEvent());
                    },
                    child: Container(
                      height: 90,
                      width: 100,
                      decoration: BoxDecoration(
                        color: cimenaChecked == true
                            ? Colors.red[300]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Cinemas",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: appFont,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        restauranttChecked = false;
                        cimenaChecked = false;
                        hotelChecked = true;
                      });
                      offerProvider.model = "Hotels";
                      offerProvider.add(FetchOffersEvent());
                    },
                    child: Container(
                      height: 90,
                      width: 100,
                      decoration: BoxDecoration(
                        color: hotelChecked == true
                            ? Colors.red[300]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Hotels",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontFamily: appFont,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Container(
                width: width * 0.4,
                child: Center(
                  child: Divider(
                    color: Colors.red,
                    thickness: 2.0,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<ItemBloc, ItemStates>(
                  builder: (context, state) {
                    var result;
                    if (state is OffersLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is OffersLoadedState) {
                      result = state.response;
                    } else if (state is OffersFailedState) {
                      return Center(
                        child: Container(
                          height: height * 0.3,
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(emptyData),
                                height: height * 0.2,
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
                        var offerList = [];
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          snapshot.data.docs.forEach((element) {
                            TargetModel model =
                                TargetModel.fromJson(element.data());
                            if (model.offer != 0) {
                              offerList.add(element.data());
                            }
                          });
                        }
                        return ListView.builder(
                          itemCount: offerList.length,
                          itemBuilder: (context, index) {
                            return ItemView(
                              targetMap: offerList[index],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
