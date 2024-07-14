import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class AddManualBook extends StatefulWidget {
  const AddManualBook({super.key});

  @override
  State<AddManualBook> createState() => _AddManualBookState();
}

class _AddManualBookState extends State<AddManualBook> {
  final nameController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  final ratingController = TextEditingController();
  final totalChapterController = TextEditingController();
  final categoryController = TextEditingController();
  final genreController = TextEditingController();
  final languageController = TextEditingController();
  final onPageController = TextEditingController();

  Future<void> addBook() async {
    if (nameController.text.isEmpty ||
        authorController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        ratingController.text.isEmpty ||
        totalChapterController.text.isEmpty ||
        categoryController.text.isEmpty ||
        genreController.text.isEmpty ||
        languageController.text.isEmpty ||
        onPageController.text.isEmpty) {
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

    const String url = 'http://localhost:5500/api/books/addBook';
    final Map<String, dynamic> body = {
      'name': nameController.text,
      'author': authorController.text,
      'rating': double.tryParse(ratingController.text) ?? 0.0,
      'totalChapter': int.tryParse(totalChapterController.text) ?? 0,
      'category': categoryController.text,
      'genre': genreController.text,
      'language': languageController.text,
      'description': descriptionController.text,
      'onPage': int.tryParse(onPageController.text) ?? 0,
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
            content: Text('Book added successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Error: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add book'),
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
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 128, 128, 1),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Spacer(),
            const Text(
              'Add Book',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Book Name',
                  hintText: 'Enter book name',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: 'Author',
                  hintText: 'Enter author name',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: ratingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  hintText: 'Enter rating',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: totalChapterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Total Chapters',
                  hintText: 'Enter total chapters',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  hintText: 'Enter category',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: genreController,
                decoration: const InputDecoration(
                  labelText: 'Genre',
                  hintText: 'Enter genre',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: languageController,
                decoration: const InputDecoration(
                  labelText: 'Language',
                  hintText: 'Enter language',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: onPageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Current Page',
                  hintText: 'Enter current page you are on right now',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter description',
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(0, 128, 128, 1),
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
                onPressed: addBook,
                child: const Text(
                  'Add Book',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
