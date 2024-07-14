import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:story_stack/config/routes/app_routes.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String _avatarPath = 'assets/avatars/Avatar 1.png';
  final List<String> _avatarList =
      List.generate(22, (index) => 'assets/avatars/Avatar ${index + 1}.png');
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final userPrefs = UserSharedPrefs();
    await userPrefs.init();
    final user = await userPrefs.getUser();
    final userId = user?['_id'];
    print('userId: $userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User ID not found, please login again'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final url = 'http://localhost:5500/api/user/getUserById/$userId';
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      setState(() {
        _userData = jsonDecode(response.body)['userDetail'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch user data: ${response.reasonPhrase}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _editAvatar() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: _avatarList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _avatarPath = _avatarList[index];
                });
                Navigator.pop(context);
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    _avatarList[index],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime createdAt = DateTime.parse(_userData?['createdAt']);
    final String formattedDate = DateFormat('yyyy-MMM-dd').format(createdAt);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: _userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.yellow[900]),
                        child: IconButton(
                          icon: const Icon(
                            Icons.logout,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _logout(context);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 100,
                            backgroundImage: AssetImage(_avatarPath),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blueAccent,
                                  width: 2,
                                ),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue[900],
                                  size: 23,
                                ),
                                onPressed: _editAvatar,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildUserInfoRow('Email', _userData?['email']),
                          const SizedBox(height: 16),
                          _buildUserInfoRow('Phone', _userData?['phone']),
                          const SizedBox(height: 16),
                          _buildUserInfoRow('Joined on', formattedDate),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.editProfileRoute,
                            arguments: {
                              'name': _userData?['name'],
                              'email': _userData?['email'],
                              'phone': _userData?['phone'],
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(0, 128, 128, 0.9),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_add_sharp,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Color(0xFFFFFBFF),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-password');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(0, 128, 128, 0.9),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_square,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Change Password',
                              style: TextStyle(
                                color: Color(0xFFFFFBFF),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildUserInfoRow(String label, String? value) {
    return Row(
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value ?? 'N/A',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Confirm Logout",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await UserSharedPrefs().deleteUserToken();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushReplacementNamed(context, '/signin');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
