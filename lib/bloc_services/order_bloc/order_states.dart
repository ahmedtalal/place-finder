import 'package:flutter/material.dart';

abstract class OrderStates {}

class OrderInitialState extends OrderStates {}

class OrderLoadedState extends OrderStates {}

class OrderLoadingState extends OrderStates {
  var result;
  OrderLoadingState({
    @required this.result,
  });
}

class OrderFailedLoadedState extends OrderStates {
  var message;
  OrderFailedLoadedState({
    @required this.message,
  });
}

class OrderAddedState extends OrderStates {
  var message;
  OrderAddedState({
    @required this.message,
  });
}

class OrderNotAddedState extends OrderStates {
  var message;
  OrderNotAddedState({
    @required this.message,
  });
}
