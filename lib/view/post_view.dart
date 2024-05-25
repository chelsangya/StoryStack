import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class PostView extends StatefulWidget {
  final String title;
  final String author;
  final String content;
  final String timestamp;
  final int commentCount;
  final List<String> comments;

  const PostView({
    super.key,
    required this.title,
    required this.author,
    required this.content,
    required this.timestamp,
    required this.commentCount,
    required this.comments,
  });
   @override
  State<PostView> createState() => _PostViewState();

}

class _PostViewState extends State<PostView> {
  List<String> comments = []; // List to store comments

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(
        context,
        widget.title,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'By ${widget.author}',
                style: TextStyle(fontSize: 18.0, color: Colors.grey[500]),
              ),
              const SizedBox(height: 16.0),
              Text(
                textAlign: TextAlign.justify,
                widget.content,
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 16.0),

              SizedBox(
                height: 200,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.comments[index]),
                      );
                    },
                    itemCount: widget.comments.length),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: comments
                    .map((comment) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(comment),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16.0),
              // Text(
              //   '${widget.commentCount} Comments',
              //   style: const TextStyle(
              //       fontSize: 20.0, fontWeight: FontWeight.bold),
              // ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Add a comment...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                setState(() {
                  comments.add('New comment: ${_controller.text}');
                  _controller.clear();
                });
              },
            ),
          ),
          controller: _controller,
        ),
      ),
    );
  }

  final TextEditingController _controller = TextEditingController();
}
