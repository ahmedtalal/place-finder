import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/repository/auth_repository_model.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_events.dart';
import 'package:online_booking_places/bloc_services/auth_bloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthRepoModel authRepoModel;
  var model;
  AuthBloc({
    @required this.authRepoModel,
  }) : super(IntialState());

  @override
  Stream<AuthStates> mapEventToState(AuthEvents event) async* {
    if (event is RegisterEvent) {
      yield IntialState();
      try {
        var result = await authRepoModel.register(model);
        if (result == true) {
          yield AuthSucessed();
        } else {
          yield AuthFailed(error: "Authentication Error");
        }
      } on FirebaseAuthException catch (e) {
        yield AuthFailed(error: e.code);
      } catch (e) {
        yield AuthFailed(error: e.message ?? 'An unknown error occured');
      }
    } else if (event is LoginEvent) {
      yield IntialState();
      try {
        var credential = await authRepoModel.login(model);
        if (credential != null) {
          yield AuthSucessed();
        } else {
          yield AuthFailed(error: "Authentication Error");
        }
      } on FirebaseAuthException catch (e) {
        yield AuthFailed(error: e.code);
      } catch (e) {
        yield AuthFailed(error: e.message ?? 'An unknown error occured');
      }
    }
  }
}
