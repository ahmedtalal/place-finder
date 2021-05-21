import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';
import 'package:online_booking_places/models/review_model.dart';
import 'package:online_booking_places/models/target_model.dart';

class ItemOperations extends RepositoryModel {
  FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  addData(model) async {
    bool result;
    CollectionReference collRef = _store.collection(model.type);
    DocumentReference docRef = collRef.doc(model.id);
    Map<String, dynamic> data = TargetModel.toJson(model);
    await docRef.set(data).whenComplete(() {
      result = true;
      print(result);
    }).catchError((onError) {
      result = false;
      print(result);
    });
    return result;
  }

  @override
  deleteData(model) {
    throw UnimplementedError();
  }

  @override
  getAllData(model) {
    CollectionReference collRef = _store.collection(model);
    return collRef.snapshots();
  }

  @override
  getSpecialData(model) {
    throw UnimplementedError();
  }

  @override
  updateData(model) {
    throw UnimplementedError();
  }

  getAllReviews(var model) {
    print(model);
    CollectionReference collRef =
        _store.collection("AllReviews").doc(model).collection("Reviews");
    return collRef.snapshots();
  }

  addReview(model) async {
    bool result;
    CollectionReference collRef = _store.collection("AllReviews");
    DocumentReference docRef =
        collRef.doc(model.itemId).collection("Reviews").doc(model.reviewId);
    ReviewModel reviewModel = ReviewModel.anotherModel(
      reviewId: model.reviewId,
      userId: model.userId,
      message: model.message,
      rating: model.rating,
    );
    Map<String, dynamic> data = ReviewModel.toJson(reviewModel);
    await docRef.set(data).whenComplete(() {
      result = true;
      print(result);
    }).catchError((onError) {
      result = false;
      print(result);
    });
    return result;
  }

  getAllOffers(var model) {
    CollectionReference collRef = _store.collection(model);
    return collRef.snapshots();
  }
}
