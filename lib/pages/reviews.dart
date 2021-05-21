import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/reviews_bloc.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/reviews_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/review_view.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/pages/add_review.dart';

// ignore: must_be_immutable
class ReviewsPage extends StatefulWidget {
  var itemId;
  ReviewsPage({
    @required this.itemId,
  });
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var itemProvider = BlocProvider.of<ReviewsBloc>(context);
    itemProvider.model = widget.itemId;
    itemProvider.add(FetchItemReviews());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ActionWidget(
                        onClick: () {
                          Navigator.of(context).pop(context);
                        },
                        icon: Icons.arrow_back_ios_rounded,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: appFont,
                        ),
                      ),
                    ],
                  ),
                  ActionWidget(
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (c) => AddReview(
                            itemId: widget.itemId,
                          ),
                        ),
                      );
                    },
                    icon: Icons.add,
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: BlocBuilder<ReviewsBloc, ReviewsStates>(
                  builder: (context, state) {
                    var result;
                    if (state is ReviewsLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ReviewsLoaded) {
                      result = state.response;
                    } else if (state is Reviewsfailed) {
                      print("failed");
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
                                "No reviews at this time",
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
                        if (!snapshot.hasData || snapshot.data.size == 0) {
                          print("Sized");
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
                                    "No reviews at this time",
                                    style: TextStyle(
                                      fontFamily: appFont,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print("waiting");
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          print("true");
                          List reviews = [];
                          snapshot.data.docs
                              .forEach((DocumentSnapshot element) {
                            reviews.add(element.data());
                          });
                          return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return ReviewsView(
                                data: reviews[index],
                              );
                            },
                          );
                        }
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
