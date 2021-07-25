import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_bloc.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_events.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/cart_view.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/home.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double totalPrice = 0;
  List items = [];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var cartProvider = BlocProvider.of<CartBloc>(context);
    cartProvider.add(FetchItemsFromCart());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          top: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
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
                    width: 12.0,
                  ),
                  Text(
                    "Cart",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: appFont,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              BlocBuilder<CartBloc, CartStates>(
                builder: (context, state) {
                  var result;
                  if (state is ItemsCartLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is ItemsCartLoadedState) {
                    result = state.response;
                  } else if (state is CartFailedLoadedState) {
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
                            ),
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
                        items.clear();
                        snapshot.data.docs.forEach((DocumentSnapshot element) {
                          items.add(element.data());
                        });
                        return Expanded(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return CartView(
                                data: items[index],
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 5.0,
                      child: Container(
                        height: 45.0,
                        width: 110.0,
                        color: Colors.red[300],
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Checkout",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontFamily: appFont,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.blue[300],
                    elevation: 5.0,
                    child: Container(
                      height: 45,
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<CartBloc, CartStates>(
                            builder: (context, state) {
                              var result;
                              if (state is ItemsCartLoadedState) {
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
                                    snapshot.data.docs
                                        .forEach((DocumentSnapshot element) {
                                      Map<String, dynamic> price =
                                          element.data();
                                      totalPrice =
                                          totalPrice + price["newPrice"];
                                    });
                                    return Text(
                                      "Total price is : $totalPrice",
                                      style: TextStyle(
                                        fontFamily: appFont,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
