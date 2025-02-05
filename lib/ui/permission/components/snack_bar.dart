import 'package:flutter/material.dart';

class SnackBarComponent {
  // static model -> untuk mempertahankan value dari function yang dipanggil
  // klo parameter required di function pakenya {} klo di construstor pake required
  static void showSnackBar(BuildContext context, String message, {bool isError = false} ) { //buildcontext itu class
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            )
            )
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.blueGrey,
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      ));
  }
}