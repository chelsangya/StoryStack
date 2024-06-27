import 'package:flutter/material.dart';

Widget myPasswordField({
  required TextEditingController controller,
  required String labelText,
  required bool isPasswordVisible,
  required ValueChanged<bool> onToggle,

  required BuildContext context,
}) {
  return TextFormField(
    controller: controller,
    obscureText: !isPasswordVisible,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        // color:
        //     isDarkMode ? Colors.white : Theme.of(context).colorScheme.primary,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          // color:
          //     isDarkMode ? Colors.white : Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          // color: isDarkMode
          //     ? Colors.blue
          //     : Theme.of(context).colorScheme.secondary,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          // color: isDarkMode ? Colors.yellow : Colors.red,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorStyle: TextStyle(
        // color: isDarkMode ? Colors.grey : Colors.red,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.grey,
        ),
        onPressed: () {
          onToggle(!isPasswordVisible);
        },
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '$labelText is empty';
      }
      return null;
    },
  );
}