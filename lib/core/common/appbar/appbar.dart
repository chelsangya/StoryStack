import 'package:flutter/material.dart';

AppBar myCustomAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color.fromRGBO(0, 128, 128, 1),
    foregroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.of(context).pushNamed('/settings');
          },
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 150,
          ),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.forum, color: Colors.white, size: 30),
          onPressed: () {
            Navigator.of(context).pushNamed('/forum');
          },
        ),
      ],
    ),
  );
}
