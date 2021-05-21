import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/firebase_operations/item_operations.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_events.dart';
import 'package:online_booking_places/bloc_services/product_bloc/item_states.dart';

class ItemBloc extends Bloc<ItemEvents, ItemStates> {
  RepositoryModel repositoryModel;
  var model;
  var reviewModel;
  ItemBloc({
    @required this.repositoryModel,
  }) : super(InitialState());

  @override
  Stream<ItemStates> mapEventToState(ItemEvents event) async* {
    if (event is AddingItemEvent) {
      try {
        var response = await repositoryModel.addData(model);
        if (response == true) {
          yield AddingItemScuessedState();
        } else {
          yield AddingItemFailedState();
        }
      } catch (e) {
        yield AddingItemFailedState();
      }
    } else if (event is FetchItemsEvent) {
      yield ItemsLoadingState();
      try {
        var result = repositoryModel.getAllData(model);
        yield ItemsLoadedState(response: result);
      } catch (e) {
        yield ItemsFailedState();
      }
    } else if (event is FetchOffersEvent) {
      yield OffersLoadingState();
      try {
        var result = (repositoryModel as ItemOperations).getAllOffers(model);
        yield OffersLoadedState(response: result);
      } catch (e) {
        yield OffersFailedState();
      }
    }
  }
}
