import 'package:flutter/material.dart';
import 'package:story_stack/config/routes/app_routes.dart';
import 'package:story_stack/core/shared_pref/user_shared_prefs.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        String? token;
        var data = await UserSharedPrefs().getUserToken();
        if (data.isRight()) {
          token = data.getOrElse(() => null);
        }

        if (token == null) {
          Navigator.of(context).pushReplacementNamed(AppRoute.signinRoute);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoute.homeRoute);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: const Color.fromRGBO(0, 128, 128, 1),
            ),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
