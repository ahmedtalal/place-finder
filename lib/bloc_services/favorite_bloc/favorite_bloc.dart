import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/firebase_operations/favorite_operations.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/bloc_services/favorite_bloc/favorite_events.dart';
import 'package:online_booking_places/bloc_services/favorite_bloc/favorite_states.dart';

class FavoriteBloc extends Bloc<FavoriteEvents, FavoriteStates> {
  RepositoryModel favRepo;
  var itemId;
  FavoriteBloc({
    @required this.favRepo,
  }) : super(InitialFavoriteState());

  @override
  Stream<FavoriteStates> mapEventToState(FavoriteEvents event) async* {
    if (event is FavClickEvent) {
      try {
        var result =
            await (favRepo as FavoriteOperations).searchFavoriteItem(itemId);
        if (result == true) {
          favRepo.deleteData(itemId);
          yield DeleteFavSucessState(response: "Successfully deleted");
        } else {
          favRepo.addData(itemId);
          yield AddFavSucessState(response: "Successfully added");
        }
      } catch (e) {
        yield FavClickFailedState();
      }
    } else if (event is FetchFavItemsEvent) {
      yield FavItemsLoadingState();
      try {
        var result = favRepo.getAllData(itemId);
        yield FavItemsLoadedState(reposnse: result);
      } catch (e) {
        yield FavItemsErrorState();
      }
    } else if (event is IsFavoriteEvent) {
      try {
        var result =
            await (favRepo as FavoriteOperations).searchFavoriteItem(itemId);
        if (result == true) {
          yield FavState();
        } else {
          yield UnFavState();
        }
      } catch (e) {}
    }
  }
}
