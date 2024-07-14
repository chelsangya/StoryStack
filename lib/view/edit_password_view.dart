import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';
import 'package:story_stack/core/widgets/my_password_field.dart';

class EditPasswordView extends StatefulWidget {
  const EditPasswordView({super.key});

  @override
  State<EditPasswordView> createState() => _EditPasswordViewState();
}

class _EditPasswordViewState extends State<EditPasswordView> {
  final LocalAuthentication auth = LocalAuthentication();
  bool canAuthenticateWithBiometrics = false;
  final oldController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();
  bool isPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  // TextEditingController addressController = TextEditingController();
  late String image;

  @override
  void initState() {
    super.initState();
    checkBiometricAuthentication();
    // Simulate fetching user details
    fetchUserDetails();
  }

  Future<void> checkBiometricAuthentication() async {
    try {
      canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      if (!canAuthenticateWithBiometrics) {
        canAuthenticateWithBiometrics = await auth.isDeviceSupported();
      }
    } catch (e) {
      print('Error checking biometric authentication: $e');
    }
    setState(() {});
  }

  Future<void> updatePassword() async {
    bool authenticated = await authenticate('Authenticate to change password');
    if (authenticated) {
      _savePasswordChanges();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> editPassword(BuildContext context) async {
    final String currentPassword = oldController.text;
    final String newPassword = newController.text;

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    String? token;
    var data = await UserSharedPrefs().getUserToken();
    data.fold((l) => token = null, (r) => token = r!);

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    const url = 'http://localhost:5500/api/user/updateUserPassword';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User password edited successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Failed to edit profile: ${responseBody['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to edit profile: ${response.reasonPhrase}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> authenticate(String val) async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: val,
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: true,
        ),
      );
      return authenticated;
    } catch (e) {
      print('Biometric authentication error: $e');
      return false;
    }
  }

  void togglePasswordVisibility(bool isVisible) {
    setState(() {
      isPasswordVisible = isVisible;
    });
  }

  Future<void> fetchUserDetails() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(context, 'Edit Password'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                myPasswordField(
                    controller: oldController,
                    labelText: 'Current Password',
                    isPasswordVisible: isPasswordVisible,
                    onToggle: togglePasswordVisibility,
                    context: context),
                const SizedBox(height: 20),
                TextFormField(
                  controller: newController,
                  obscureText: !isNewPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: const TextStyle(),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: const TextStyle(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isNewPasswordVisible = !isNewPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value != confirmController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: confirmController,
                  obscureText: !isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: const TextStyle(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value != confirmController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),
            // Save Button
            Center(
              child: SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 128, 128, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                        color: Color(0xFFFFFBFF),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Confirm Update",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Are you sure you want to update your password?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Update cancelled'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                editPassword(context);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _savePasswordChanges() {
    print("Password changes saved!");
  }
}
