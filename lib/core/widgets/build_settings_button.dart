import 'package:flutter/material.dart';

Widget buildSettingsButton({
  required BuildContext context,
  required VoidCallback onPressed,
  required IconData icon,
  required String label,
}) {
  return SizedBox(
    height: 60,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // backgroundColor:Colors.grey[900] ,
        elevation: 4,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.teal[600]!,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.teal[600],
            // color: Colors.yellow[900],
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[800],
              // color: Colors.yellow[900],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
