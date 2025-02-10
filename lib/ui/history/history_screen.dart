import 'package:attendance_app/services/data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class _AttendanceHistoryScreenState extends StatefulWidget {
  const _AttendanceHistoryScreenState({super.key});

  @override
  State<_AttendanceHistoryScreenState> createState() => __AttendanceHistoryScreenStateState();
}

class __AttendanceHistoryScreenStateState extends State<_AttendanceHistoryScreenState> {
    final DataService dataService = DataService(); // Class dan Objek (kenapa dipanggil 2x?)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance History"),
      ),
      body: StreamBuilder( //untuk membungkus widget2 kita menjadi satu kesatuan (ui manage well)
        stream: dataService.dataCollection.snapshots(), // stream : inisialisasi data yg kita punya, snapshot : manage data yg kita ambil (memberitahukan ke UI oh kita sudah bisa dipake)
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) { // ini klo ga ada data
            return const Center(
              child: Text("Nothing Data")
            );
          }

          final data = snapshot.data!.docs;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return 
            },
          );
        },
      ),
    );
  }
}