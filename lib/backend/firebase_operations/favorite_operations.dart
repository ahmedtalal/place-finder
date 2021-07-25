import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:online_booking_places/backend/repository/repository_model.dart';

class FavoriteOperations extends RepositoryModel {
  User _user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore _store = FirebaseFirestore.instance;

  @override
  addData(model) {
    bool result = false;
    CollectionReference collRef = _store.collection("FavoritItems");
    DocumentReference docRef =
        collRef.doc(_user.uid).collection("items").doc(model.id);
    Map<String, dynamic> data = {
      "itemId": model.id,
      "type": model.type,
    };
    docRef.set(data).whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  deleteData(model) {
    bool result = false;
    CollectionReference collRef = _store.collection("FavoritItems");
    DocumentReference docRef =
        collRef.doc(_user.uid).collection("items").doc(model.id);
    docRef.delete().whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  getAllData(model) {
    CollectionReference collRef =
        _store.collection("FavoritItems").doc(_user.uid).collection("items");
    return collRef.snapshots();
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

  searchFavoriteItem(var itemId) async {
    var result = false;
    CollectionReference collRef =
        _store.collection("FavoritItems").doc(_user.uid).collection("items");
    await collRef.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((QueryDocumentSnapshot element) {
        var id = element["itemId"];
        print("favorite item id : $id");
        if (id == itemId.id) {
          result = true;
        }
      });
    });
    print("fav result :$result");
    return result;
  }
}
