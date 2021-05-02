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

class UserErrorState extends UserStates {}

class UserUpdatedState extends UserStates {}
