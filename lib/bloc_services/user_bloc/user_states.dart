import 'package:flutter/material.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserLoadedState extends UserStates {
  var response;
  UserLoadedState({
    @required this.response,
  });
}

class UserErrorState extends UserStates {
  var error;
  UserErrorState({
    @required this.error,
  });
}

class UserUpdatedState extends UserStates {}

class UpdatingSuccessedState extends UserStates {}

class UpdatingFailedState extends UserStates {}
