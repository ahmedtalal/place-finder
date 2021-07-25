import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_booking_places/backend/repository/auth_repository_model.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/models/user_model.dart';

class AuthOperations extends AuthRepoModel {
  FirebaseAuth _auth = FirebaseAuth.instance;
  RepositoryModel repositoryModel;
  AuthOperations({
    @required this.repositoryModel,
  });
  AuthOperations.instance();

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
  logOut() async {
    await _auth.signOut();
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
      String userId = _auth.currentUser.uid;
      UserModel userModel = UserModel(
        name: model.name,
        email: model.newPassword,
        id: userId,
        image: "null",
        phoneNumber: model.phoneNumber,
      );
      result = await repositoryModel.addData(userModel);
    }
    return result;
  }

  @override
  Future<void> updatePassword(model) async {
    User user = FirebaseAuth.instance.currentUser;
    await user.updatePassword(model);
  }
}
