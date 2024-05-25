import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SignupView> {
  bool _passwordVisible = false;
  bool _passwordcVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _togglecPasswordVisibility() {
    setState(() {
      _passwordcVisible = !_passwordcVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      'assets/images/logob.png',
                      width: 320,
                      height: 130,
                    ),
                  ),
                  const Text(
                    'Register your account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'johndoe@gmail.com',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(color: Colors.green)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          hintText: '9800000000',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '********',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1)),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        obscureText: !_passwordVisible,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          hintText: '********',
                          hintStyle: const TextStyle(color: Colors.grey),
                          labelStyle: const TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1)),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordcVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: _togglecPasswordVisibility,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        obscureText: !_passwordcVisible,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/avatar-selection');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(0, 128, 128, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(
                                color: Color(0xFFFFFBFF),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signin');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Container(
                      //         margin: const EdgeInsets.only(
                      //           left: 10,
                      //           right: 10,
                      //         ),
                      //         child: const Divider(
                      //           color: Colors.black,
                      //           height: 2,
                      //         ),
                      //       ),
                      //     ),
                      //     const Text(
                      //       'Or sign in with',
                      //       style: TextStyle(color: Colors.black),
                      //     ),
                      //     Expanded(
                      //       child: Container(
                      //         margin: const EdgeInsets.only(
                      //           left: 10,
                      //           right: 10,
                      //         ),
                      //         child: const Divider(
                      //           color: Colors.black,
                      //           height: 2,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 10),
                      // ElevatedButton.icon(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.face),
                      //   label: const Text('Sign in with Face ID'),
                      //   style: ElevatedButton.styleFrom(
                      //     shadowColor: const Color(0xFF0B2B3D),
                      //     side: const BorderSide(color: Color(0xFF0B2B3D)),
                      //     foregroundColor: Colors.black,
                      //     backgroundColor: Colors.white,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: 10),
                      // ElevatedButton.icon(
                      //   onPressed: () {},
                      //   icon: const Icon(Icons.g_mobiledata),
                      //   label: const Text('Sign in with Google'),
                      //   style: ElevatedButton.styleFrom(
                      //     foregroundColor: Colors.black,
                      //     backgroundColor: Colors.white,
                      //     shadowColor: const Color(0xFF0B2B3D),
                      //     side: const BorderSide(color: Color(0xFF0B2B3D)),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30),
                      //     ),
                      //   ),
                      // ),
                    ],
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
