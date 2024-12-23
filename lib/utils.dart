import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, {required bool isSuccess}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(isSuccess ? Icons.check_circle : Icons.error, color: Colors.white),
        SizedBox(width: 10),
        Expanded(child: Text(message)),
      ],
    ),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}