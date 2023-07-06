import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: GestureDetector(
          onTap: () => context.go('/home'),
          child: Row(
            children: [
              Image.asset(
                'assets/app_icon_inverted.png',
                width: 75,
                height: 75,
              ),
              const SizedBox(width: 20),
              const Text('FAQ', style: TextStyle(fontSize: 30, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
