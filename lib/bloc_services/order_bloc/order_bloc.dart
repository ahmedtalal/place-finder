import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/bloc_services/order_bloc/order_events.dart';
import 'package:online_booking_places/bloc_services/order_bloc/order_states.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  RepositoryModel repository;
  var model;

  OrderBloc({
    @required this.repository,
  }) : super(OrderInitialState());

  @override
  Stream<OrderStates> mapEventToState(OrderEvents event) async* {
    if (event is ShowOrdersEvents) {
      yield OrderLoadingState(result: null);
      try {
        // TODO implement show all orders function here
      } catch (e) {
        yield OrderFailedLoadedState(message: null);
      }
    } else if (event is AddedOrderEvents) {
      var response = repository.addData(model);
      if (response == true) {
        yield OrderAddedState(message: "the order added successfully");
      } else {
        yield OrderNotAddedState(message: "Error in adding process");
      }
      try {} catch (e) {
        yield OrderNotAddedState(message: "Error in adding process");
      }
    }
  }
}
