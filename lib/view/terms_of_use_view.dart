import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(context, 'Terms of Use'),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Acceptance of Terms\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'By accessing or using the BookMark application, you agree to be bound by these Terms of Use. If you do not agree with any part of these terms, you may not use the application. These terms govern your use of the application and any associated services.\n\n',
                  ),
                  TextSpan(
                    text: 'Description of Service\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'The BookMark application provides users with the ability to track their series and book progress. It allows users to organize their reading and viewing habits, discover new content, and connect with other book and series enthusiasts.\n\n',
                  ),
                  TextSpan(
                    text: 'User Accounts\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'To access and utilize certain features of the application, users may be required to create an account. User accounts allow for personalized experiences, including tracking reading progress, engaging in community discussions, and receiving notifications about upcoming releases.\n\n',
                  ),
                  TextSpan(
                    text: 'User Conduct\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'Users agree to use the application in compliance with all applicable laws and regulations. Users must conduct themselves responsibly and refrain from engaging in any activity that disrupts or interferes with the operation of the application or violates the rights of others.\n\n',
                  ),
                  TextSpan(
                    text: 'Intellectual Property\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'All content and materials provided through the application, including but not limited to text, images, and user-generated content, are owned or licensed by BookMark and are protected by intellectual property laws. Users may not use, reproduce, or distribute any content from the application without proper authorization.\n\n',
                  ),
                  TextSpan(
                    text: 'Privacy Policy\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'User privacy is important to us. Our Privacy Policy outlines how we collect, use, and protect user information. By using the application, users consent to the collection and processing of their data as described in the Privacy Policy.\n\n',
                  ),
                  TextSpan(
                    text: 'Termination\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'BookMark reserves the right to terminate or suspend user access to the application at any time, without prior notice or liability, for violations of these Terms of Use or any other reason deemed necessary by BookMark.\n\n',
                  ),
                  TextSpan(
                    text: 'Changes to Terms\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'BookMark may update or modify these Terms of Use at any time without prior notice. Users are responsible for regularly reviewing these terms to stay informed of any changes. Continued use of the application after changes indicates acceptance of the revised terms.\n\n',
                  ),
                  TextSpan(
                    text: 'Contact Information\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'If users have any questions, concerns, or feedback regarding these Terms of Use or the BookMark application, they can contact us at info@bookmark.com. We value user input and strive to address inquiries promptly and effectively.\n\n',
                  ),
                ],
              ),
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
