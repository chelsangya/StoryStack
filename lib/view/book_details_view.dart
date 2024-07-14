import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class BookDetailsView extends StatefulWidget {
  final String id;
  final String title;
  final String author;
  final String description;
  final String image;
  final double rating;
  final String genre;
  final String language;
  final int totalChapter;

  const BookDetailsView({
    super.key,
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.rating,
    required this.genre,
    required this.language,
    required this.totalChapter,
  });

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  int? selectedChapter;

  Future<void> addToList() async {
    if (selectedChapter == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a chapter'),
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

    const String url = 'http://localhost:5500/api/list/add';
    final Map<String, dynamic> body = {
      'bookId': widget.id,
      'page': selectedChapter,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Success: $responseData');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to list successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Error: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add to list'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Network error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(context, 'Book Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.image,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {},
                          starCount: 5,
                          rating: widget.rating,
                          size: 25.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half_outlined,
                          color: Colors.yellow[900],
                          borderColor: Colors.yellow[900],
                          spacing: 0.0,
                        ),
                        Text(
                          '${widget.rating} rated by readers.',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Author: ${widget.author}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Genre: ${widget.genre}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Language: ${widget.language}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {},
                          starCount: 5,
                          rating: widget.rating,
                          size: 25.0,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half_outlined,
                          color: Colors.yellow[900],
                          borderColor: Colors.yellow[900],
                          spacing: 0.0,
                        ),
                        Text(
                          '${widget.rating} rated by readers.',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Author(s): ${widget.author}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Genre: ${widget.genre}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Language: ${widget.language}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Chapter',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                List.generate(widget.totalChapter, (index) {
                              bool isSelected = selectedChapter == index + 1;
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setModalState(() {
                                      selectedChapter =
                                          isSelected ? null : index + 1;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    backgroundColor:
                                        isSelected ? Colors.teal : null,
                                  ),
                                  child: Text('${index + 1}'),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.teal,
                              )),
                          onPressed: () async {
                            await addToList();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add to List'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
