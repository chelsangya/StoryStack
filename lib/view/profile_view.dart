import 'package:flutter/material.dart';
import 'package:story_stack/core/common/appbar/appbar.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: myCustomAppBar(context,),
      body: const Center(
        child: Text('Profile View'),
      ),
    );
  }
}