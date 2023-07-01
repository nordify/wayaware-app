import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayaware_app/backend/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final double _initialScale = 1.0;
  final double _targetScale = 1.1;
  final int _animationDuration = 1000; // Adjust the animation duration (in milliseconds)

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: _initialScale,
      end: _targetScale,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Image.asset(
                        'assets/app_icon.png',
                        width: 350.0,
                      ),
                    );
                  }),
            ),
            const Spacer(),
            SizedBox(
              width: 350,
              height: 65,
              child: ElevatedButton.icon(
                onPressed: () => Authentication.signInWithGoogle(),
                icon: Padding(
                  padding: const EdgeInsets.only(left: 1.0),
                  child: SizedBox(
                    height: 20,
                    child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2008px-Google_%22G%22_Logo.svg.png',
                        fit: BoxFit.cover),
                  ),
                ),
                label: const Text('Login with Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 350,
              height: 65,
              child: ElevatedButton.icon(
                onPressed: () => Authentication.signInWithApple(),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 3),
                  child: SizedBox(
                    height: 20,
                    child: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Apple_logo_white.svg/1724px-Apple_logo_white.svg.png',
                        fit: BoxFit.cover),
                  ),
                ),
                label: const Text('Login with Apple'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
