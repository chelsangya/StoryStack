import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/view/post_view.dart';

class ForumView extends StatelessWidget {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(
        context,
        'All Posts',
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildPostItem(context, index);
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

  Widget _buildPostItem(BuildContext context, int index) {
    String title = 'Post Title $index';
    String author = 'Author $index';
    String timestamp = '2 hours ago';
    String content =
        'This is the content of post $index. It can be quite long. This is the content of post $index. It can be quite long. This is the content of post $index. It can be quite long. This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.';
    int commentCount = 5;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PostView(
              title: title,
              author: author,
              content: content,
              timestamp: timestamp,
              commentCount: commentCount,
              comments: const [],
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
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                        'assets/avatars/Avatar 1.png'), // Replace 'assets/avatar.png' with your actual image path
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
                  const Spacer(),
                  Text(
                    timestamp,
                    style: TextStyle(color: Colors.grey[700]),
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
