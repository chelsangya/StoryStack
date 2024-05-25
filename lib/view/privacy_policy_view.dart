import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: internalAppBar(context, 'Privacy Policy'),
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
                    text: 'Privacy Policy\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'User privacy is important to us. Our Privacy Policy outlines how we collect, use, and protect user information. By using the application, users consent to the collection and processing of their data as described in the Privacy Policy.\n\n',
                  ),
                  TextSpan(
                    text: 'Data Collection\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'We collect information from you when you register on our site, place an order, subscribe to our newsletter, respond to a survey, or fill out a form.\n\n',
                  ),
                  TextSpan(
                    text: 'Use of Information\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'Any of the information we collect from you may be used in one of the following ways:\n',
                  ),
                  TextSpan(
                    text: '• To personalize your experience\n'
                        '• To improve our website\n'
                        '• To improve customer service\n'
                        '• To process transactions\n'
                        '• To administer a contest, promotion, survey, or other site feature\n'
                        '• To send periodic emails\n\n',
                  ),
                  TextSpan(
                    text: 'Data Protection\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'We implement a variety of security measures to maintain the safety of your personal information when you enter, submit, or access your personal information.\n\n',
                  ),
                  TextSpan(
                    text: 'Contact Information\n',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextSpan(
                    text:
                        'If you have any questions or concerns regarding our Privacy Policy, please contact us at info@bookmark.com.\n\n',
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
