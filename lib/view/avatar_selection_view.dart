import 'package:flutter/material.dart';

class AvatarSelectionView extends StatefulWidget {
  const AvatarSelectionView({super.key});
  @override
  State<AvatarSelectionView> createState() => _AvatarSelectionViewState();
}

class _AvatarSelectionViewState extends State<AvatarSelectionView> {
  String? _selectedAvatar;

  final List<String> _avatarList =
      List.generate(22, (index) => 'assets/avatars/Avatar ${index + 1}.png');

  @override
  void initState() {
    super.initState();
    _selectedAvatar = _avatarList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    'Select Your Avatar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text(
                      'Selected Avatar',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Center(
                child: _selectedAvatar != null
                    ? Image.asset(
                        _selectedAvatar!,
                        height: 150,
                        width: 150,
                      )
                    : const Center(
                        child: Text(
                          'No Avatar Selected',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.blue,
                    ),
                    Text(
                      'Available Avatars:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: _avatarList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAvatar = _avatarList[index];
                            });
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                _avatarList[index],
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
        child: ElevatedButton(
          onPressed: () {
            _showTermsDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 128, 128, 1),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text('CONTINUE',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFFBFF),
              )),
        ),
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms of Use"),
          content: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'By clicking "CONTINUE", you agree to the following Terms of Use:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              Text(
                'By accessing or using the BookMark application, you agree to be bound by these Terms of Use. If you do not agree with any part of these terms, you may not use the application.',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
              // Add more terms here as needed
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User Registered'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Agree'),
            ),
          ],
        );
      },
    );
  }
}
