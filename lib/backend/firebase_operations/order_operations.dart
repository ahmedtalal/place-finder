import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/models/order_model.dart';

class OrderOperations extends RepositoryModel {
  FirebaseFirestore _Store = FirebaseFirestore.instance;
  User _user = FirebaseAuth.instance.currentUser;
  @override
  addData(model) async {
    bool result = false;
    CollectionReference collRef = _Store.collection("Old Orders");
    DocumentReference docRef =
        collRef.doc(_user.uid).collection("orders").doc(model.orderId);
    Map<String, dynamic> data = OrderModel.toJson(model);
    await docRef.set(data).whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  deleteData(model) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  getAllData(model) {
    // TODO: implement getAllData
    throw UnimplementedError();
  }

  @override
  getSpecialData(model) {
    // TODO: implement getSpecialData
    throw UnimplementedError();
  }

  @override
  updateData(model) {
    // TODO: implement updateData
    throw UnimplementedError();
  }
}
