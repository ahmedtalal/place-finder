import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_bloc.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/reviews_bloc.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/reviews_states.dart';
import 'package:online_booking_places/components/action_widget.dart';
import 'package:online_booking_places/components/text_input_widget_copy.dart';
import 'package:online_booking_places/constants.dart';
import 'package:online_booking_places/models/review_model.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class AddReview extends StatefulWidget {
  String itemId;
  AddReview({
    @required this.itemId,
  });
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  var formKey = GlobalKey<FormState>();
  double rating;
  var message;

  bool isProgressed = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var reviewProvider = BlocProvider.of<ReviewsBloc>(context);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: ModalProgressHUD(
          inAsyncCall: isProgressed,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.06,
                ),
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
                      "adding Review",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: appFont,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 19.0,
                ),
                SingleChildScrollView(
                  primary: true,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.8,
                          height: height * 0.2,
                          child: TextInputWidgetNoController(
                            message: "message",
                            icon: Icons.message,
                            onClick: (newValue) {
                              message = newValue;
                            },
                            onValidate: (value) {
                              if (value.isEmpty) {
                                return "this field is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        RatingBar(
                          onRatingChanged: (rate) =>
                              setState(() => rating = rate),
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          halfFilledIcon: Icons.star_half,
                          isHalfAllowed: true,
                          filledColor: Colors.green,
                          emptyColor: Colors.redAccent,
                          halfFilledColor: Colors.amberAccent,
                          size: 48,
                        ),
                        SizedBox(
                          height: 19.0,
                        ),
                        BlocListener<ItemBloc, ItemStates>(
                          listener: (context, state) {
                            if (state is AddingReviewSuccesed) {
                              Navigator.of(context).pop();
                            } else if (state is AddingReviewFailed) {
                              snackbarValidate(
                                  "adding review  failed", context);
                            }
                          },
                          child: BlocBuilder<ItemBloc, ItemStates>(
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  if (formKey.currentState.validate()) {
                                    setState(() {
                                      isProgressed = true;
                                    });
                                    ReviewModel reviewModel = ReviewModel(
                                      itemId: widget.itemId,
                                      reviewId: Uuid().v1(),
                                      userId:
                                          FirebaseAuth.instance.currentUser.uid,
                                      message: message,
                                      rating: rating,
                                    );
                                    reviewProvider.model = reviewModel;
                                    reviewProvider.add(AddingReviewEvent());
                                  }
                                },
                                child: Container(
                                  width: width * 0.7,
                                  height: height * 0.076,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "add review",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: appFont,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void snackbarValidate(String s, BuildContext context) {
    setState(() {
      isProgressed = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          s,
        ),
      ),
    );
  }
}
