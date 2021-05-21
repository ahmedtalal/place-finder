import 'package:flutter/material.dart';

class ReviewModel {
  String itemId, reviewId, message, userId;
  double rating;

  ReviewModel({
    @required this.itemId,
    @required this.reviewId,
    @required this.userId,
    @required this.message,
    @required this.rating,
  });

  ReviewModel.anotherModel({
    @required this.reviewId,
    @required this.userId,
    @required this.message,
    @required this.rating,
  });

  ReviewModel.fromJson(Map<String, dynamic> data) {
    this.reviewId = data["reviewId"];
    this.userId = data["userId"];
    this.message = data["message"];
    this.rating = data["rating"];
  }

  static Map<String, dynamic> toJson(ReviewModel model) => {
        "reviewId": model.reviewId,
        "userId": model.userId,
        "message": model.message,
        "rating": model.rating,
      };
}
