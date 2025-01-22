import 'dart:io';

import 'package:attendance_app/ui/attend/camera_screen.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  final XFile? image;

  const AttendanceScreen({super.key, this.image});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState(this.image);
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  _AttendanceScreenState(this.image);

  XFile? image;
  String address = "", date = "", time = "", dateTime = "", status = "Attend";
  bool isLoading = false;
  double lat = 0.0, long = 0.0; // lat = vertikal kordinat dan long = horizontal kordinat
  int dateHours = 0, minute = 0;
  final controller = TextEditingController();
  final CollectionReference dataCollection = FirebaseFirestore.instance.collection('attendance'); // 'attendance' itu adalah key

  @override // nama syntax nya adalah annotation
  void initState() {
    handleLocationPermission();
    setDateTime();
    setAttendStatus();

    if (image != null) {
      isLoading = true;
      getGeoLocationPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(), //kembali ke halaman awal
          ),
        title: const Text(
          "Attendance Report",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                  color: Colors.blueAccent
                ),
                child: const Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(Icons.face_retouching_natural_outlined),
                    SizedBox(height: 12),
                    Text(
                      "Please Scan Your Face!",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                child: Text(
                  "Capture Image",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                 ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const CameraScreen())
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    width: size.width,
                    height: 150,
                    child: DottedBorder( // border putus2
                    radius: const Radius.circular(10),
                    borderType: BorderType.RRect,
                    color: Colors.blueAccent,
                    strokeWidth: 1,
                    dashPattern: const [5, 5],
                      child: SizedBox.expand( // sama kyk Expanded
                        child: FittedBox(
                          child: image != null
                          ? Image.file(File(image!.path), fit: BoxFit.cover)
                          : const Icon(Icons.camera_enhance_outlined)
                        ),
                      )
                  ),
                )
              ),
             Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Your Name",
                  hintText: "Please type your name here",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blueAccent)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color: Colors.blueAccent)
                  )
                ),
               ),
              )
            ],
          ),
        ) ,
      ),
    );
  }
}