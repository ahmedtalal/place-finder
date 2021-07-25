import 'package:flutter/material.dart';

abstract class ItemStates {}

class InitialState extends ItemStates {}

class AddingItemScuessedState extends ItemStates {}

class AddingItemFailedState extends ItemStates {}

class ItemsLoadingState extends ItemStates {}

class ItemsLoadedState extends ItemStates {
  var response;
  ItemsLoadedState({
    @required this.response,
  });
}

class SpecialItemsLoadedState extends ItemStates {
  var response;
  SpecialItemsLoadedState({
    @required this.response,
  });
}

class ItemsFailedState extends ItemStates {}

class OffersLoadingState extends ItemStates {}

class OffersLoadedState extends ItemStates {
  var response;
  OffersLoadedState({
    @required this.response,
  });
}

class OffersFailedState extends ItemStates {}

class UpdateSuccessed extends ItemStates {}

class UpdatedFailed extends ItemStates {}

class DeletedSuccessed extends ItemStates {}

class DeletedFailed extends ItemStates {}
