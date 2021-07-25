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
    bool result = false;
    CollectionReference collRef = _store.collection(model.type);
    DocumentReference docRef = collRef.doc(model.id);
    docRef.delete().whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  getAllData(model) {
    CollectionReference collRef = _store.collection(model);
    return collRef.snapshots();
  }

  @override
  getSpecialData(model) {
    List items = [];
    model.forEach((element) {
      CollectionReference collRef = _store.collection(element["type"]);
      DocumentReference docRef = collRef.doc(element["itemId"]);
      items.add(docRef.snapshots());
    });
    print("object ${items.length}");
    return items;
  }

  @override
  updateData(model) {
    bool result = false;
    CollectionReference collRef = _store.collection(model.type);
    DocumentReference docRef = collRef.doc(model.id);
    Map<String, dynamic> data = TargetModel.toJson(model);
    docRef.update(data).whenComplete(() {
      result = true;
    });
    return result;
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
