import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_events.dart';
import 'package:online_booking_places/bloc_services/cart_bloc/cart_states.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  RepositoryModel repositoryModel;
  var dataModel;
  var id;
  var model;
  CartBloc({
    @required this.repositoryModel,
  }) : super(InitialCartState());

  @override
  Stream<CartStates> mapEventToState(CartEvents event) async* {
    if (event is AddItemTOCart) {
      try {
        var result = await repositoryModel.addData(dataModel);
        if (result == true) {
          yield CartAddedSuccessfullyState();
        } else {
          yield CartAddedFailedState();
        }
      } catch (e) {
        yield CartAddedFailedState();
      }
    } else if (event is FetchItemsFromCart) {
      yield ItemsCartLoadingState();
      try {
        var response = repositoryModel.getAllData("model");
        yield ItemsCartLoadedState(response: response);
      } catch (e) {
        yield CartFailedLoadedState();
      }
    } else if (event is UpdateCartInfo) {
      try {
        var response = await repositoryModel.updateData(model);
        if (response == true) {
          yield CartUpdatedSuccessfullyState();
        } else {
          yield CartUpdatedFailedState();
        }
      } catch (e) {
        yield CartUpdatedFailedState();
      }
    } else if (event is DeleteCartInfo) {
      try {
        var response = await repositoryModel.deleteData(id);
        if (response == true) {
          yield CartDeletedSuccessfullyState();
        } else {
          yield CartDeletedFailedState();
        }
      } catch (e) {
        yield CartDeletedFailedState();
      }
    }
  }
}
