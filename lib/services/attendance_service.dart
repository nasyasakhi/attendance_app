import 'package:attendance_app/ui/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// an entry point fo submitting the attendance report
final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance');

Future<void> submitAttendanceReport(
  BuildContext context, //mempresentasikan UI yang ada saat ini 
  String address, 
  String name, 
  String attendanceStatus, 
  String timeStamp
  ) async {
    showLoaderDialog(context);
    dataCollection.add(
      {
        'name' : name,
        'address' : address,
        'description' : attendanceStatus,
        'time' : timeStamp
      }
      ).then((result) {
        Navigator.of(context).pop(); // pop = replace
        try { // ketika data sudah benar 
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                     ),
                     SizedBox(width: 10),
                     Text(
                      "Attendance submitted successfully",
                      style: TextStyle(color: Colors.white),
                     )
                ],
              ),
              backgroundColor: Colors.orangeAccent,
              shape: StadiumBorder(),
              behavior: SnackBarBehavior.floating,
            )
          );
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => const HomeScreen())
          );
        }
        catch (e) {// catch disini klo data salah/error // e = error, i = information, d = debug, f = firebose
          ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Ups! $e", 
                    style: const TextStyle(color: Colors.white)
              ))
            ],
           )
          )
        );
        }
      });
    }

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog( // pop up notification
   content: Row(
    children: [
      const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
      ),
      Container(
        margin: const EdgeInsets.only(left: 20),
        child: const Text("Checking the data..."),
      )
    ],
   ),
  );
  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (BuildContext context) {
      return alert;
    }
  );
}