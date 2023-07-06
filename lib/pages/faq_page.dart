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
    body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/about'),
                          icon: const Icon(Icons.info, color: Colors.white),
                        ),
                        const Text(
                          'About',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () => context.go('/contact'),
                          icon: const Icon(Icons.contact_mail, color: Colors.white),
                        ),
                        const Text(
                          'Kontakt',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '© 2023 Your Company. Alle Rechte vorbehalten.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}