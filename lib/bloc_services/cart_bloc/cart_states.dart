import 'package:flutter/material.dart';

abstract class CartStates {}

class InitialCartState extends CartStates {}

class ItemsCartLoadingState extends CartStates {}

class ItemsCartLoadedState extends CartStates {
  var response;
  ItemsCartLoadedState({
    @required this.response,
  });
}

class CartAddedSuccessfullyState extends CartStates {}

class CartAddedFailedState extends CartStates {}

class CartFailedLoadedState extends CartStates {}

class CartUpdatedSuccessfullyState extends CartStates {}

class CartUpdatedFailedState extends CartStates {}

class CartDeletedSuccessfullyState extends CartStates {}

class CartDeletedFailedState extends CartStates {}
