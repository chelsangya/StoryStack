import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/internalappbar.dart';
import 'package:story_stack/core/widgets/build_settings_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool notifications = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: internalAppBar(context, 'Settings'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  notifications
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  size: 35,
                  color: notifications ? Colors.green : Colors.red,
                ),
                title: const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                trailing: Transform.scale(
                  scale: 1.2,
                  child: Switch(
                    thumbColor: MaterialStateProperty.all(Colors.white),
                    activeTrackColor: Colors.green,
                    inactiveTrackColor: Colors.red,
                    thumbIcon: MaterialStateProperty.all(
                      Icon(
                        Icons.notifications_active,
                        color: Colors.yellow[900],
                      ),
                    ),
                    value: notifications,
                    onChanged: (value) {
                      setState(() {
                        notifications = value;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildSettingsButton(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/contact');
                  },
                  icon: Icons.contact_mail,
                  label: 'Contact Us'),
              const SizedBox(
                height: 20,
              ),
              buildSettingsButton(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/faq');
                  },
                  icon: Icons.question_answer,
                  label: 'Frequently Asked Questions'),
              const SizedBox(
                height: 20,
              ),
              buildSettingsButton(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/privacy');
                  },
                  icon: Icons.privacy_tip,
                  label: 'Privacy Policy'),
              const SizedBox(
                height: 20,
              ),
              buildSettingsButton(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/terms');
                  },
                  icon: Icons.article,
                  label: 'Terms of Use'),
              const SizedBox(
                height: 20,
              ),
              buildSettingsButton(
                  context: context,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/about');
                  },
                  icon: Icons.info,
                  label: 'About Us'),
            ],
          ),
        ));
  }
}
