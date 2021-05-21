import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_events.dart';
import 'package:online_booking_places/bloc_services/user_bloc/user_states.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  RepositoryModel repositoryModel;
  var model;
  UserBloc({
    @required this.repositoryModel,
  }) : super(UserInitialState());

  @override
  Stream<UserStates> mapEventToState(UserEvents event) async* {
    if (event is GetUserEvent) {
      yield UserLoadingState();
      try {
        var response = repositoryModel.getSpecialData(model);
        yield UserLoadedState(response: response);
      } catch (e) {
        yield UserErrorState(error: e);
      }
    } else if (event is UpdateUserEvent) {
      yield UserLoadingState();
      try {
        var response = await repositoryModel.updateData(model);
        if (response == true) {
          yield UserUpdatedState();
        } else {
          yield UserErrorState(error: "updating error");
        }
      } catch (e) {
        yield UserErrorState(error: e);
      }
    } else if (event is FetchUsersEvent) {
      yield UserLoadingState();
      try {
        var response = repositoryModel.getAllData(model);
        yield UserLoadedState(response: response);
      } catch (e) {
        yield UserErrorState(error: e);
      }
    }
  }
}
