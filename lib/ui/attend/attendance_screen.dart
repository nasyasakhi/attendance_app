import 'package:attendance_app/services/location_service.dart';
import 'package:attendance_app/services/timestamp_service.dart';
import 'package:camera/camera.dart';
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
  String addressPlaceholder = '', datePlaceholder = '', timePlaceholder = '', timeStampPlaceholder = '', statusPlaceholder = 'Attend';
  bool isLoading = false;
  final controller = TextEditingController();

  @override 
  void initState() {
    super.initState();
    handleLocationPermission(context);
    setDateTime((date, time, timeStamp) { // siap2 untuk ambil data dari awal sesaat setelah dia di compile
      setState(() {
        datePlaceholder = date;
        timePlaceholder = time;
        timeStampPlaceholder = timeStamp;
      });
    });
    setAttendStatus((status) {
      setState(() {
        statusPlaceholder = status;
      });
    });

    if (image != null) {
      isLoading = true;
      getGeoLocationPosition(context, (position) {
        setState(() { // set pertama kali sebelum dia ada perubahan data maka dari itu nilai false
          isLoading = false;
          getAddressFromLongLat(position, (address) {
            setState(() {
              addressPlaceholder = address;
            });
          });
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return const Scaffold(
     backgroundColor: Colors.white,
     
    );
  }
}