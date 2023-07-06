import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SizedBox(
        height: 300,
        child: Image.asset(
          'assets/app_icon.png',
          fit: BoxFit.contain,
        ),
      )),
    );
  }
}
