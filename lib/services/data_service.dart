import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

  Future<QuerySnapshot> getData() { // pengantar dari API 
    return dataCollection.get();
  }

  Future<void> deleteData(String docId) {
    return dataCollection.doc(docId).delete();
  }
}