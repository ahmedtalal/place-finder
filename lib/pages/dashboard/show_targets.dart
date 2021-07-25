import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/item_view.dart';
import 'package:online_booking_places/constants.dart';

// ignore: must_be_immutable
class ShowTargets extends StatefulWidget {
  String target;
  ShowTargets({
    @required this.target,
  });
  @override
  _ShowTargetsState createState() => _ShowTargetsState();
}

class _ShowTargetsState extends State<ShowTargets> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var itemProvider = BlocProvider.of<ItemBloc>(context);
    itemProvider.model = widget.target;
    itemProvider.add(FetchItemsEvent());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.06,
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
                    widget.target,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontFamily: appFont,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.target,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
