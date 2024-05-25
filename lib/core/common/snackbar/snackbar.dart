import 'package:flutter/material.dart';

void mySnackBar({
  required String message,
  BuildContext? context,
  Color? color,
}) {
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color ?? Colors.green,
    duration: const Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  ));
}