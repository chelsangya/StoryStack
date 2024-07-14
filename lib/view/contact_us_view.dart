import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  Future<void> addContact(BuildContext context) async {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isEmpty || content.isEmpty) {
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

    const url = 'http://localhost:5500/api/contact/add';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': title,
          'description': content,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contact added successfully'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Failed to add contact: ${responseBody['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add contact: ${response.reasonPhrase}'),
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
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Us')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fill the form below to contact us',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _contentController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Content',
                      alignLabelWithHint: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () async {
                        await addContact(context);
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Alternatively, you can contact us via:',
                style: TextStyle(fontSize: 18)),
            const Text('Email: info@bookmark.com',
                style: TextStyle(fontSize: 18)),
            const Text(
              'Phone Number: 9807689098',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
