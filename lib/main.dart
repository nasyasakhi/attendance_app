import 'package:attendance_app/ui/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // harus menggunakan initializeApp jika ingin memakai layanan lain ke firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // data diambil dari file google-services.json
      apiKey: 'AIzaSyB1WOapxpwR5nP9Bqe8PpK1E51x5DFAlD0', // ambil dari current key
      appId: '1:429188350890:android:8ed1ce8f770d80f7d721d3', // ambil dari mobilesdk_app_id
      messagingSenderId: '429188350890', // ambil dari project_number
      projectId: 'attendance-app-6ab55' // ambil dari project_id
    )
  );
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cardTheme: const CardTheme(surfaceTintColor: Colors.white),
        dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true
      ),
     home: const HomeScreen(),
    );
  }
}