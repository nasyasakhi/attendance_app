import 'dart:math';

import 'package:attendance_app/utils/google_ml_kit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceDetectorComponent {
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
          enableContours: true,
          enableClassification: true,
          enableTracking: true,
          enableLandmarks: true));

  Future<void> detectFaces(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final faces = await faceDetector.processImage(inputImage);

    for (Face face in faces) {
      final Rect boundingBox = face.boundingBox;

      // menghandle posisi wajah secara vertikal
      final double? verticalPosition = face.headEulerAngleY;

      // menghandle posisi wajah secara horizontal
      final double? horizontalPosition = face.headEulerAngleZ;

      //Perkondisian apabila face landmark sudah aktif, ditandai oleh (mulut, mata, pipi, hidung, dan telinga)
      final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      if (leftEar != null) {
        final Point<int> leftEarPosition = leftEar
            .position; // kalau telinganya terdeteksi maka dia akan return posisi telinga tersebut (titik kordinat)
        print("Left Ear Posistion: $leftEarPosition");
      }

      // Perkondisian apabila klasifikasi wajahnya sudah aktif (ditandai dengan bibir tersenyum)
      if (face.smilingProbability != null) {
        final double? smilingProbability = face.smilingProbability;
        print("Smile Probability: $smilingProbability");
      }
      // Perkondisian apabila fitur tracking wajah
      if (face.trackingId != null) {
        final int? trackingId = face.trackingId;
        print("Tracking ID: $trackingId");
      }
    }
  }
}
