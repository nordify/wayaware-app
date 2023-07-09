import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with AutomaticKeepAliveClientMixin<AboutPage> {
  get title => null;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Hier hinzugefügt
          children: [
            Image.asset(
              'assets/app_icon_inverted.png',
              width: 75,
              height: 75,
            ),
            const Text(
              'About',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Colors.white),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  child: const Text(
                    'Wayaware',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Text(
                    'Bei der Awareness-App setzen wir uns für die Förderung des Bewusstseins und der Unterstützung von Menschen mit Behinderungen ein. Unser Ziel ist es, Barrieren abzubauen, Vorurteile zu bekämpfen und eine inklusive Gesellschaft zu schaffen, in der alle Menschen gleiche Chancen und Teilhabemöglichkeiten haben.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30, bottom: 15),
                  child: const Text(
                    'Unsere Funktionen',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Text(
                    'Die Awareness-App bietet eine Vielzahl von Funktionen, um das Bewusstsein zu schärfen und Informationen über verschiedene Arten von Behinderungen bereitzustellen. Von Erfahrungsberichten und Geschichten von Menschen mit Behinderungen bis hin zu Ressourcen und Tipps zur Barrierefreiheit – unsere App ist ein umfassendes Werkzeug für alle, die mehr über diese wichtigen Themen erfahren möchten.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30, bottom: 15),
                  child: const Text(
                    'Unterstützen Sie uns!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const Text(
                    'Wir freuen uns über Ihre Unterstützung bei der Verbreitung des Bewusstseins für Menschen mit Behinderungen. Teilen Sie unsere App mit Ihren Freunden und Familienmitgliedern, engagieren Sie sich in lokalen Gemeinschaften und setzen Sie sich für barrierefreie Umgebungen ein.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  height: 10,
                )
              ],
            ),
          ),
          Container(
            color: Colors.black,
            height: 15,
          ),
          Container(
            color: Colors.black,
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
              ],
            ),
          ),
          Container(
            color: Colors.black,
            height: 30,
          ),
          Container(
            color: Colors.black,
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
          Container(
            color: Colors.black,
            height: 120,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
