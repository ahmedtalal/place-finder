import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_booking_places/backend/repository/auth_repository_model.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';

class AuthOperations extends AuthRepoModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  RepositoryModel repositoryModel;
  AuthOperations({
    @required this.repositoryModel,
  });
  @override
  checkCurrentUser() {
    bool result = false;
    User user = _auth.currentUser;
    if (user != null) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  @override
  logOut() {
    bool result = false;
    _auth.signOut().whenComplete(() {
      result = true;
    }).onError((error, stackTrace) {
      result = false;
    });
    return result;
  }

  @override
  login(model) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: model.email, password: model.password);
    return credential;
  }

  @override
  register(model) async {
    var result = false;
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: model.email, password: model.password);
    if (credential != null) {
      result = await repositoryModel.addData(model);
    }
    return result;
  }
}
