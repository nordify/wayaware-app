import 'package:flutter/material.dart';
import 'package:wayaware_app/backend/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/app_icon.png',
                    width: 200.0,
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton.icon(
                  onPressed: () => Authentication.signInWithGoogle(),
                  icon: const Icon(Icons.android),
                  label: const Text('Login with Google'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton.icon(
                  onPressed: () => Authentication.signInWithApple(),
                  icon: const Icon(Icons.apple),
                  label: const Text('Login with Apple'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}