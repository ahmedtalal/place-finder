import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_booking_places/backend/firebase_operations/auth_operations.dart';
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
        yield AuthFailed(error: e.code + " or No internet connection");
      } catch (e) {
        yield AuthFailed(
            error: e.message.toString() + 'An unknown error occured');
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
        yield AuthFailed(error: e.code + " or No internet connection");
      } catch (e) {
        yield AuthFailed(
            error: e.message.toString() + 'An unknown error occured');
      }
    } else if (event is AdminAuthEvent) {
      try {
        var credential = await authRepoModel.login(model);
        if (credential != null) {
          yield AdminAuthSuccessed();
        } else {
          yield AuthFailed(error: "Authentication Error");
        }
      } on FirebaseAuthException catch (e) {
        yield AuthFailed(error: e.code + " or No internet connection");
      } catch (e) {
        yield AuthFailed(
            error: e.message.toString() + 'An unknown error occured');
      }
    } else if (event is LogOutEvent) {
      try {
        await AuthOperations.instance().logOut();
        yield LogOutSucessed();
      } catch (e) {
        yield LogOutFailed(error: "Error in Logout");
      }
    } else if (event is UpdatePassEvent) {
      try {
        await AuthOperations.instance().updatePassword(model);
        yield UpdatePassSuccessded();
      } catch (e) {
        yield UpdatePassFailed();
      }
    }
  }
}
