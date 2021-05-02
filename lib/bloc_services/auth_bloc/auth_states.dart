import 'package:flutter/material.dart';

abstract class AuthStates {}

class IntialState extends AuthStates {}

class AuthSucessed extends AuthStates {}

class AuthFailed extends AuthStates {
  var error;
  AuthFailed({
    @required this.error,
  });
}
