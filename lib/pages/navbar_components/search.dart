import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/components/item_view.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/models/target_model.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> targets = ["Cinema", "Rastaurants", "Hotels"];
  var target;
  var position;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var itemProvider = BlocProvider.of<ItemBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * 0.34,
                    height: 33.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        6.0,
                      ),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 5.0,
                      ),
                      child: DropdownButton(
                        items: targets.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: appFont,
                                fontSize: 12.0,
                              ),
                            ),
                          );
                        }).toList(),
                        isDense: true,
                        iconSize: 20.0,
                        hint: Text(
                          "Targets",
                          style: TextStyle(
                            fontSize: 10.0,
                            fontFamily: appFont,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            // you code is here >>>
                            target = value;
                          });
                        },
                        value: target,
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.5,
                    height: 33.0,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: appFont,
                      ),
                      decoration: InputDecoration(
                        labelText: "your position",
                        labelStyle: TextStyle(
                          fontSize: 10.0,
                          fontFamily: appFont,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          position = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                width: width * 0.26,
                height: 32.0,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (target == "Cinema") {
                        itemProvider.model = "Cinema";
                      } else if (target == "Rastaurants") {
                        itemProvider.model = "Rastaurants";
                      } else if (target == "Hotels") {
                        itemProvider.model = "Hotels";
                      }
                      itemProvider.add(FetchItemsEvent());
                    });
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: appFont,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
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
                child: BlocListener<ItemBloc, ItemStates>(
                  listener: (context, state) {
                    if (state is ItemsFailedState) {
                      snackbarValidate("no data in this place", context);
                    }
                  },
                  child: BlocBuilder<ItemBloc, ItemStates>(
                    builder: (context, state) {
                      var result;
                      if (state is ItemsLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ItemsLoadedState) {
                        result = state.response;
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
                              TargetModel model =
                                  TargetModel.fromJson(element.data());
                              if (model.location == position) {
                                print(model.location);
                                items.add(element.data());
                              }
                            });
                            if (items.length == 0) {
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
                            } else {
                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return ItemView(
                                    targetMap: items[index],
                                  );
                                },
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void snackbarValidate(String s, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
      ),
    );
  }
}
