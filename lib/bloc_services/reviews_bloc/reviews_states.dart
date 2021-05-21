import 'package:flutter/material.dart';

abstract class ReviewsStates {}

class InitialState extends ReviewsStates {}

class ReviewsLoading extends ReviewsStates {}

class ReviewsLoaded extends ReviewsStates {
  var response;
  ReviewsLoaded({
    @required this.response,
  });
}

class Reviewsfailed extends ReviewsStates {}

class AddingReviewSuccesed extends ReviewsStates {}

class AddingReviewFailed extends ReviewsStates {}
