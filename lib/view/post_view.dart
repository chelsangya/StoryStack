import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_stack/config/routes/app_routes.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class PostView extends StatefulWidget {
  final String id;
  final String title;
  final String author;
  final String content;
  final String? image;
  final int? commentCount;
  final List<Map<String, dynamic>> comments;

  const PostView({
    super.key,
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.image,
    required this.comments,
    this.commentCount,
  });

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<Map<String, dynamic>> comments = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    comments = widget.comments;
  }

  Future<void> _addComment(String postId, String comment) async {
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

    const url = 'http://localhost:5500/api/post/addComment';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'postId': postId,
          'description': comment,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, AppRoute.homeRoute);
        final data = json.decode(response.body);
        setState(() {
          comments.add({
            'description': comment,
            'by': {'name': 'Current User'},
            'date': DateTime.now().toString(),
          });
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Comment added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Failed to add comment: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add comment'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error adding comment: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding comment'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(
        context,
        'Post Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: widget.image != null &&
                                  widget.image!.isNotEmpty
                              ? NetworkImage(widget.image!)
                              : const AssetImage('assets/avatars/Avatar 1.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'By ${widget.author}',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.content,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                '${comments.length} Comments',
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              ...comments.map((comment) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundImage:
                            AssetImage('assets/avatars/Avatar 1.png'),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment['by']['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(comment['description']),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                controller: _controller,
              ),
            ),
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _addComment(widget.id, _controller.text);
                  _controller.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.teal,
                backgroundColor: Colors.white,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.teal),
                ),
              ),
              child: const Text(
                'Add Comment',
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
