import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(context, 'FAQ'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Expanded(
              //   child: ListView(
              //     children: const [
              //       FaqItem(
              //         question: 'How do I create a new post?',
              //         answer:
              //             'To create a new post, click on the floating action button at the bottom right corner of the screen. Fill in the title and content of your post, then click on the submit button.',
              //       ),
              //       FaqItem(
              //         question: 'How do I view my posts?',
              //         answer:
              //             'To view your posts, click on the "My Posts" tab on the home screen. This will display a list of all the posts you have created.',
              //       ),
              //       FaqItem(
              //         question: 'How do I delete a post?',
              //         answer:
              //             'To delete a post, click on the "My Posts" tab on the home screen. Swipe left on the post you want to delete, then click on the delete button.',
              //       ),
              //       FaqItem(
              //         question: 'How do I add a book or series to my list?',
              //         answer:
              //             'To add a book or series to your list, go to discover,  click on the "+" button beside the card or on the book or series details page . This will add the book or series to your list for easy access later.',
              //       ),
              //       FaqItem(
              //         question: 'How do I remove a book or series from my list?',
              //         answer:
              //             'To remove a book or series from your list, go to "My List" and click on the "x" button beside the list item. This will remove the book or series from your list.',
              //       ),
              //       FaqItem(
              //         question: 'How do I change my password?',
              //         answer:
              //             'To change your password, go to the profile page and click on the "Change Password" button. Enter your current password, then enter your new password and confirm it. Click on the submit button to change your password.',
              //       ),
              //       FaqItem(
              //         question: 'How do I contact support?',
              //         answer:
              //             'To contact support, go to settings and click on the "Contact Us" and fill out the contact form. Enter your name, email address, and message, then click on the submit button. A support representative will get back to you as soon as possible.',
              //       ),
              //       FaqItem(
              //         question: 'How do I update list items?',
              //         answer:
              //             'To update list items, go to "My List" and click on the item you want to add. You can then update the item progress as needed. Click on the "Save" button to save your changes.',
              //       ),
              //     ],
              //   ),
              // ),

              // use flutter faq

              FAQ(
                question: 'How do I create a new post?',
                answer:
                    'To create a new post, click on the floating action button at the bottom right corner of the screen. Fill in the title and content of your post, then click on the submit button.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 5),
              FAQ(
                question: 'How do I view my posts?',
                answer:
                    'To view your posts, click on the "My Posts" tab on the home screen. This will display a list of all the posts you have created.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 5),
              FAQ(
                question: 'How do I delete a post?',
                answer:
                    'To delete a post, click on the "My Posts" tab on the home screen. Swipe left on the post you want to delete, then click on the delete button.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 5),
              FAQ(
                question: 'How do I add a book or series to my list?',
                answer:
                    'To add a book or series to your list, go to discover,  click on the "+" button beside the card or on the book or series details page . This will add the book or series to your list for easy access later.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 5),
              FAQ(
                question: 'How do I remove a book or series from my list?',
                answer:
                    'To remove a book or series from your list, go to "My List" and click on the "x" button beside the list item. This will remove the book or series from your list.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 5),
              FAQ(
                question: 'How do I change my password?',
                answer:
                    'To change your password, go to the profile page and click on the "Change Password" button. Enter your current password, then enter your new password and confirm it. Click on the submit button to change your password.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 5),
              FAQ(
                question: 'How do I contact support?',
                answer:
                    'To contact support, go to settings and click on the "Contact Us" and fill out the contact form. Enter your name, email address, and message, then click on the submit button. A support representative will get back to you as soon as possible.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
              const SizedBox(height: 5),
              FAQ(
                question: 'How do I update list items?',
                answer:
                    'To update list items, go to "My List" and click on the item you want to add. You can then update the item progress as needed. Click on the "Save" button to save your changes.',
                expandedIcon: const Icon(Icons.minimize),
                collapsedIcon: const Icon(Icons.add),
                ansDecoration: BoxDecoration(
                    color: Colors.yellow.withOpacity(0.1),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                queDecoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 128, 128, 0.2),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                separator: Container(height: 500, color: Colors.black),
                showDivider: false,
                queStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold),
                ansStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
