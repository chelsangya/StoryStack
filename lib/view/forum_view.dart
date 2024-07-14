import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';
import 'package:story_stack/view/post_view.dart';

class ForumView extends StatefulWidget {
  const ForumView({super.key});

  @override
  _ForumViewState createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {
  List<dynamic> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
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
    const url = 'http://localhost:5500/api/post/get';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          posts = data['post'];
          isLoading = false;
        });
      } else {
        // Handle error
        print('Failed to load posts: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching posts: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(
        context,
        'All Posts',
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return _buildPostItem(context, posts[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context).pushNamed('/addPost');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPostItem(BuildContext context, dynamic post) {
    String title = post['title'];
    String author = post['by']['name'];
    String content = post['description'];
    String image = post['by']['userImageUrl'] ?? '';
    List<Map<String, dynamic>> comments =
        List<Map<String, dynamic>>.from(post['comments'] ?? []);
    int commentCount = comments.length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PostView(
              id: post['_id'],
              title: title,
              author: author,
              content: content,
              commentCount: commentCount,
              comments: comments,
              image: image,
            ),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'By $author',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: image.isNotEmpty
                        ? NetworkImage(image)
                        : const AssetImage('assets/avatars/Avatar 1.png')
                            as ImageProvider,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(Icons.comment),
                  const SizedBox(width: 8.0),
                  Text(
                    '$commentCount comments',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
