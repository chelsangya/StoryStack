import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
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
    return Scaffold(
      appBar: internalAppBar(context, 'Contact Us'),
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
                    onPressed: () {
                      // TODO: Save Post
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
            )),
            //  provide email and phone number as alternative
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
