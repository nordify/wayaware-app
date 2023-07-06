import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: Row(
          children: [
            Image.asset(
              'assets/app_icon_inverted.png',
              width: 75,
              height: 75,
            ),
            const SizedBox(width: 20),
            const Text('About', style: TextStyle(fontSize: 30, color: Colors.white)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Willkommen zur Awareness-App!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Unsere Mission',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Bei der Awareness-App setzen wir uns für die Förderung des Bewusstseins und der Unterstützung von Menschen mit Behinderungen ein. Unser Ziel ist es, Barrieren abzubauen, Vorurteile zu bekämpfen und eine inklusive Gesellschaft zu schaffen, in der alle Menschen gleiche Chancen und Teilhabemöglichkeiten haben.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Unsere Funktionen',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Die Awareness-App bietet eine Vielzahl von Funktionen, um das Bewusstsein zu schärfen und Informationen über verschiedene Arten von Behinderungen bereitzustellen. Von Erfahrungsberichten und Geschichten von Menschen mit Behinderungen bis hin zu Ressourcen und Tipps zur Barrierefreiheit – unsere App ist ein umfassendes Werkzeug für alle, die mehr über diese wichtigen Themen erfahren möchten.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Unterstützen Sie uns!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Wir freuen uns über Ihre Unterstützung bei der Verbreitung des Bewusstseins für Menschen mit Behinderungen. Teilen Sie unsere App mit Ihren Freunden und Familienmitgliedern, engagieren Sie sich in lokalen Gemeinschaften und setzen Sie sich für barrierefreie Umgebungen ein.',
                style: TextStyle(fontSize: 18),
              ),
            ),
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
                          onPressed: () => context.go('/faq'),
                          icon: const Icon(Icons.question_answer, color: Colors.white),
                        ),
                        const Text(
                          'FAQ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Aktion für den Tipp auf Kontakt
                          },
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