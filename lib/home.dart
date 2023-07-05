import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/pages/about_page.dart';
import 'package:wayaware/pages/faq_page.dart';
import 'package:wayaware/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          title: SizedBox(
              height: 60,
              child: Image.asset(
                "assets/app_icon_inverted.png",
              ))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/map');
                  },
                  child: const Text("Map"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  child: const Text("Settings"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container( 
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Hier wird die Hintergrundfarbe des Buttons festgelegt
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SettingsPage();
                      },
                    ));
                  },
                  child: Text("Settings"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  child: const Text("Settings"),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container( 
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Hier wird die Hintergrundfarbe des Buttons festgelegt
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FAQPage();
                      },
                    ));
                  },
                  child: Text("FAQ"),
                )),
          ),
        ],
      ),
    );
  }
}
