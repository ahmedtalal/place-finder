import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/firebase_operations/item_operations.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/reviews_bloc/reviews_states.dart';

class ReviewsBloc extends Bloc<ReviewsEvents, ReviewsStates> {
  RepositoryModel repositoryModel;
  var model;
  ReviewsBloc({
    @required this.repositoryModel,
  }) : super(InitialState());

  @override
  Stream<ReviewsStates> mapEventToState(ReviewsEvents event) async* {
    if (event is FetchItemReviews) {
      yield ReviewsLoading();
      try {
        var result = (repositoryModel as ItemOperations).getAllReviews(model);
        print("ssssss");
        yield ReviewsLoaded(response: result);
      } catch (e) {
        yield Reviewsfailed();
      }
    } else if (event is AddingReviewEvent) {
      try {
        var response =
            await (repositoryModel as ItemOperations).addReview(model);
        if (response == true) {
          yield AddingReviewSuccesed();
        } else {
          yield AddingReviewFailed();
        }
      } catch (e) {
        yield AddingReviewFailed();
      }
    }
  }
}
