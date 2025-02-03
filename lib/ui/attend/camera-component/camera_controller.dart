import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraControllerComponent {
  List<CameraDescription>? cameras;
  CameraController? controller;
  bool isBusy = false;

  Future<void> loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      controller = CameraController(cameras![0], ResolutionPreset.high);
      await controller!.initialize();
    }
  }

  Widget buildCameraPreview() {
    if (controller == null || !controller!.value.isInitialized) { // or itu harus negatif || negatif
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return CameraPreview(controller!);
  }
}