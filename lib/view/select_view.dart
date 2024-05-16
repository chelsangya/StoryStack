import 'package:flutter/material.dart';

class SelectView extends StatelessWidget {
  const SelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromRGBO(0, 128, 128, 1),
          ),
          // Container(
          //   constraints: const BoxConstraints.expand(),
          //   decoration: BoxDecoration(
          //     color: Colors.black.withOpacity(0.3),
          //   ),
          // ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/logo.png',
                    width: 400,
                    height: 400,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signin');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(250, 208, 44, 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(0, 128, 128, 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(0, 128, 128, 1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // border
                              side: const BorderSide(
                                width: 3,
                                color: Color.fromRGBO(250, 208, 44, 1),
                              ),
                            ),
                            child: const Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                // color: Color.fromRGBO(0, 128, 128, 1),
                                color: Color.fromRGBO(250, 208, 44, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
