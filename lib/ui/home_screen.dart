import 'package:attendance_app/ui/attend/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope( // Popscope mengontrol atau mencegah pengguna keluar dari halaman (ModalRoute) dengan tombol "Back". Make sure mau kembali/nga takut ada data yg ga kesimpen?
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if(didPop) {
          return;
        }
        _onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buidlMenuItem( // ada yang membuat parameter wajib berurutan apa itu?
                  context,
                  imagePath: "assets/images/ic_attend.png",
                  label: "Attendance Report",
                  destination: const AttendanceScreen()
                  ),
                const SizedBox(height: 40),
                _buidlMenuItem( 
                  context,
                  imagePath: "assets/images/ic_permission.png",
                  label: "Permission Report",
                  destination: const AttendanceScreen()
                  ),
                const SizedBox(height: 40),
                 _buidlMenuItem( 
                  context,
                  imagePath: "assets/images/ic_attendance_history.png",
                  label: "Attendance History",
                  destination: const AttendanceScreen()
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buidlMenuItem(
    BuildContext context, {
      required String imagePath,
      required String label,
      required Widget destination // pendefinisian class 
    }) {
    return Container(
            margin: const EdgeInsets.all(10) ,
            child: Expanded(
               child: InkWell( // efek sentuhan
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
                    },
                    child: Column(
                     children: [
                      Image(
                      image: AssetImage(imagePath),
                      height: 100,
                      width: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Attendance Report",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      )
                     ],
                    ),
                  ),
                ),
              );
            }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context, 
      builder: (context) =>
      AlertDialog(
        title: const Text(
          'Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        content: const Text(
          "Do you want to exit?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), 
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), 
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          )
        ],
      )
      )
    /* ini adalah default value ketika semua kode yang ada 
    di blok Alert Dialog tidak tereksekusi karena beberapa hal */
    ) ??
    false;
  }
}