import 'package:cloud_firestore/cloud_firestore.dart';

class Dbmovies {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;
  Dbmovies() {
    collectionReference = firebaseFirestore.collection('movies');
  }

  Future<void> insert(Map<String, dynamic> moviesmap) async {
    return collectionReference!.doc().set(moviesmap);
  }

  Future<void> update(Map<String, dynamic> moviesmap, String UID) async {
    return collectionReference!.doc(UID).update(moviesmap);
  }

  Future<void> delete(String UID) async {
    return collectionReference!.doc(UID).delete();
  }

  Stream<QuerySnapshot> Selecter() {
    return collectionReference!.snapshots();
  }
}
