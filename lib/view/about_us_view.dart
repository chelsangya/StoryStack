import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(context, 'About Us'),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About BookMark',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              // textAlign:Tex ,
              'Welcome to BookMark, your ultimate companion for tracking your series and book progress!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'At BookMark, our mission is to make it easy and enjoyable for bookworms and series enthusiasts to keep track of their reading and viewing journey. We understand the importance of staying organized and keeping up with your favorite series and books, and we\'re here to help you do just that.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Our Values',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Passion for Reading:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' We share your love for books and series and are dedicated to enhancing your reading and viewing experience.\n',
                  ),
                  TextSpan(
                    text: 'Simplicity:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' We believe in keeping things simple and user-friendly, so you can focus on what matters most—enjoying your favorite stories.\n',
                  ),
                  TextSpan(
                    text: 'Empowerment:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' We empower our users to take control of their reading and viewing habits, providing them with the tools they need to stay on track and reach their goals.\n',
                  ),
                  TextSpan(
                    text: 'Community:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' We\'re building a community of book and series lovers who can connect, share recommendations, and inspire each other on their literary journeys.',
                  ),
                ],
              ),
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),
            Text(
              'Why Choose BookMark',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Comprehensive Tracking:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' BookMark offers comprehensive tracking capabilities, allowing you to effortlessly monitor your progress across a vast library of series and books. Say goodbye to scattered notes and incomplete lists—BookMark keeps everything organized in one convenient place.\n',
                  ),
                  TextSpan(
                    text: 'Engaging Community Forum:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' Join our vibrant community forum to connect with fellow bookworms and series enthusiasts. Share your thoughts, recommendations, and favorite moments, and discover new gems recommended by like-minded readers. With BookMark, you\'re never alone on your literary journey.\n',
                    style: TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                    text: 'Stay Ahead with Upcoming Releases:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' Stay ahead of the curve with BookMark\'s upcoming releases feature. Receive notifications and updates on the latest book releases and series premieres, so you can plan your reading and viewing schedule in advance. Never miss out on the next big thing in the world of literature and entertainment.',
                  ),
                ],
              ),
              style: TextStyle(fontSize: 16),
            ),

            // SizedBox(height: 20),
            // Text(
            //   'Our Team',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   'Meet the passionate team behind BookMark:\n\n'
            //   'Sa: [Brief introduction and background]\n\n'
            //   '- [Designer Name]: [Brief introduction and background]\n\n'
            //   '- [Support Team]: [Brief introduction and role]',
            //   style: TextStyle(fontSize: 16),
            // ),
            // SizedBox(height: 20),
            // Text(
            //   'Contact Us',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   'Have questions or feedback? We\'d love to hear from you! Reach out to us at [Your Contact Information] and join the BookMark community on [Social Media Platforms] for the latest updates and discussions.',
            //   style: TextStyle(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
