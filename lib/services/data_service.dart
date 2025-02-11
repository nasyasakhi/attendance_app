import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

  // get : untuk membaca/mendapatkan data dari database
  Future<QuerySnapshot> getData() { // pengantar dari API 
    return dataCollection.get();
  }

  Future<void> deleteData(String docId) {
    // untuk menghapus data dari database
    return dataCollection.doc(docId).delete();
  }
}