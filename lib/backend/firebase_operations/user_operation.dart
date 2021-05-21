import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/models/user_model.dart';

class UserOperation extends RepositoryModel {
  CollectionReference _collRef = FirebaseFirestore.instance.collection("Users");
  @override
  addData(model) async {
    bool result = false;
    DocumentReference docRef = _collRef.doc(model.id);
    Map<String, dynamic> data = UserModel.toJson(model);
    await docRef.set(data).whenComplete(() {
      result = true;
    }).onError((error, stackTrace) {
      result = false;
    });
    return result;
  }

  @override
  deleteData(model) {
    bool result = false;
    DocumentReference docRef = _collRef.doc(model.id);
    docRef.delete().whenComplete(() {
      result = true;
    }).onError((error, stackTrace) {
      result = false;
    });
    return result;
  }

  @override
  getSpecialData(model) {
    DocumentReference docRef = _collRef.doc(model);
    return docRef.snapshots();
  }

  @override
  updateData(model) {
    bool result = false;
    Map<String, dynamic> data = UserModel.toJson(model);
    DocumentReference docRef = _collRef.doc(model.id);
    docRef.update(data).whenComplete(() {
      result = true;
    }).onError((error, stackTrace) {
      result = false;
    });
    return result;
  }

  @override
  getAllData(model) {
    return _collRef.snapshots();
  }

}
