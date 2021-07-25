import 'package:flutter/material.dart';

abstract class FavoriteStates {}

class InitialFavoriteState extends FavoriteStates {}

class AddFavSucessState extends FavoriteStates {
  var response;
  AddFavSucessState({
    @required this.response,
  });
}

class DeleteFavSucessState extends FavoriteStates {
  var response;
  DeleteFavSucessState({
    @required this.response,
  });
}

class FavClickFailedState extends FavoriteStates {}

class FavItemsLoadingState extends FavoriteStates {}

class FavItemsLoadedState extends FavoriteStates {
  var reposnse;
  FavItemsLoadedState({
    @required this.reposnse,
  });
}

class FavItemsErrorState extends FavoriteStates {}

class FavState extends FavoriteStates {}

class UnFavState extends FavoriteStates {}
