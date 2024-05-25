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
          return _buildPostCard(context, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[300],
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

  Widget _buildPostCard(BuildContext context, int index) {
    String title = 'Post Title $index';
    String author = 'Author $index';
    String timestamp = '2 hours ago';
    String content =
        'This is the content of post $index. It can be quite long. This is the content of post $index. It can be quite long. This is the content of post $index. It can be quite long. This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.This is the content of post $index. It can be quite long.';
    int commentCount = 5;
    List<String> comments = [
      'Comment 1',
      'Comment 2',
      'Comment 3',
      'Comment 4'
    ];

    return Card(
      margin:
          const EdgeInsets.only(bottom: 3.0, top: 20, left: 16.0, right: 16),
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PostView(
              title: title,
              author: author,
              content: content,
              timestamp: timestamp,
              commentCount: commentCount,
              comments: comments,
            ),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                'By $author ',
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 8.0),
              Text(
                content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  const Icon(Icons.comment),
                  const SizedBox(width: 8.0),
                  Text('$commentCount comments'),
                  const Spacer(),
                  Text(timestamp),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
