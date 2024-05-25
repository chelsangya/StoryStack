import 'package:flutter/material.dart';

AppBar internalAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: const Color.fromRGBO(0, 128, 128, 1),
    foregroundColor: Colors.white,
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_outlined,
          color: Colors.white, size: 30),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    title: Align(
      alignment: Alignment.topRight,
      child: Text(title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          )),
    ),
  );
}
