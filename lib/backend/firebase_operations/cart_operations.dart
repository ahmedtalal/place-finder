import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/models/cart_model.dart';

class CartOperations extends RepositoryModel {
  FirebaseFirestore _store = FirebaseFirestore.instance;
  User _user = FirebaseAuth.instance.currentUser;

  @override
  addData(model) async {
    bool result = false;
    CollectionReference collRef = _store.collection("Cart");
    DocumentReference docRef =
        collRef.doc(_user.uid).collection("items").doc(model.itemCartId);
    Map<String, dynamic> data = CartModel.toJson(model);
    await docRef.set(data).whenComplete(() {
      result = true;
    });
    print(result);
    return result;
  }

  @override
  deleteData(model) async {
    bool result = false;
    CollectionReference collRef = _store.collection("Cart");
    DocumentReference docRef =
        collRef.doc(_user.uid).collection("items").doc(model);
    await docRef.delete().whenComplete(() {
      result = true;
    });
    print(result);
    return result;
  }

  @override
  getAllData(model) {
    CollectionReference collRef =
        _store.collection("Cart").doc(_user.uid).collection("items");
    return collRef.snapshots();
  }

  @override
  getSpecialData(model) {
    CollectionReference collRef =
        _store.collection("Cart").doc(_user.uid).collection("items");
    DocumentReference docRef = collRef.doc(model);
    return docRef.snapshots();
  }

  @override
  updateData(model) async {
    bool result = false;
    CollectionReference collRef = _store.collection("Cart");
    DocumentReference docRef =
        collRef.doc(_user.uid).collection("items").doc(model.itemCartId);
    Map<String, dynamic> data = CartModel.toJson(model);
    await docRef.update(data).whenComplete(() {
      result = true;
    });
    print(result);
    return result;
  }
}
