import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_stack/config/routes/app_routes.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class NewPostView extends StatefulWidget {
  const NewPostView({super.key});

  @override
  State<NewPostView> createState() => _NewPostViewState();
}

class _NewPostViewState extends State<NewPostView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> addPost(BuildContext context) async {
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

      const url = 'http://localhost:5500/api/post/add';
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
                content: Text('Post added successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushNamed(context, AppRoute.forumRoute);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to add post: ${responseBody['message']}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to add post: ${response.reasonPhrase}'),
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

    return Scaffold(
      appBar: internalAppBar(context, "New Post"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
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
                onPressed: () {
                  addPost(context);
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
                  'Post',
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
}
