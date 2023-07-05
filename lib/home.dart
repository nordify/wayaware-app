import 'dart:math';

import 'package:curved_gradient/curved_gradient.dart';
import 'package:flutter/material.dart';
import 'package:wayaware/about.dart';
import 'package:wayaware/map/map_page.dart';
import 'package:wayaware/settings_page.dart';

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
            child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return MapPage();
                      },
                    ));
                  },
                  child: Text("Map"),
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
            child: Container( 
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 26, 164, 35)), // Hier wird die Hintergrundfarbe des Buttons festgelegt
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const ScrollPage();
                      },
                    ));
                  },
                  child: Text("About"),
                )),
          ),
        ],
      ),
    );
  }
}
