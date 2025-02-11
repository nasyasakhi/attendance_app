import 'package:attendance_app/services/data_service.dart';
import 'package:attendance_app/ui/history/components/attendance_card.dart';
import 'package:attendance_app/ui/history/components/delete_dialog.dart';
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
              return AttendanceHistoryCard(
                data: data[index].data() as Map<String, dynamic>,
                onDelete: () {
                  showDialog(
                    context: context, 
                    builder: (context) => DeleteDialog(
                      // untuk menjadikan index sebagai id dari data yang ada di db
                      documentId: data[index].id, 
                      dataCollection: dataService.dataCollection, 
                      //digunakan untuk memperbarui state setelah terjadi penghapusan data dr db
                      onConfirm: () { 
                        setState(() {
                          dataService.deleteData(data[index].id);
                          Navigator.pop(context);
                        });
                       },
                    )
                  );
                }
              );
            },
          );
        },
      ),
    );
  }
}