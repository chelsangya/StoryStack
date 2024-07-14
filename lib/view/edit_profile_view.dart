import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final LocalAuthentication auth = LocalAuthentication();
  bool canAuthenticateWithBiometrics = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isNewPasswordVisible = false;
  Map<String, dynamic>? _userData;
  bool isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> checkBiometricAuthentication() async {
    try {
      canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      if (!canAuthenticateWithBiometrics) {
        canAuthenticateWithBiometrics = await auth.isDeviceSupported();
      }
    } catch (e) {
      debugPrint('Error checking biometric authentication: $e');
    }
    setState(() {});
  }

  Future<void> updateProfile() async {
    bool authenticated = await authenticate('Authenticate to change profile');
    if (authenticated) {
      _saveProfileChanges();
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

  Future<void> editProfile(BuildContext context) async {
    final String name = nameController.text;
    final String email = emailController.text;
    final String phone = phoneController.text;

    if (email.isEmpty || phone.isEmpty) {
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

    const url = 'http://localhost:5500/api/user/updateUser';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User edited successfully'),
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

  @override
  Widget build(BuildContext context) {
    final userData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (userData != null) {
      nameController.text = userData['name'] ?? '';
      emailController.text = userData['email'] ?? '';
      phoneController.text = userData['phone'] ?? '';
    }

    return Scaffold(
      appBar: internalAppBar(context, 'Edit Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Save Button
            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () async {
                  await editProfile(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 128, 128, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
            "Are you sure you want to update your profile?",
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
                updateProfile();
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

  void _saveProfileChanges() {
    print("Profile changes saved!");
  }
}
