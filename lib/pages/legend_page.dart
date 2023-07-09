import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware/bloc/settings_mode_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Legend Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LegendPage(),
    );
  }
}

class LegendPage extends StatelessWidget {
  const LegendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingsBloc, Map<String, bool>>(
      builder: (context, state) {
        final accessibilityMode = state['accessibility_mode'] ?? false;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0,
              toolbarHeight: 80,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title: Text(
                "Map Legend",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: accessibilityMode ? 40 : 20),
              )),
          body: const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 100), // Adjust the bottom padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LegendItem(
                    icon: Icons.block,
                    description:
                        'Es zeigt an, dass es auf dem Weg möglicherweise Hindernisse gibt, die für Menschen mit Behinderungen eine Herausforderung darstellen könnten.',
                  ),
                  SizedBox(height: 40), // Adjust the spacing between items
                  LegendItem(
                    icon: Icons.accessible_forward,
                    description: 'Es zeigt an, dass der Weg möglicherweise für Rollstuhlfahrer schwer zu befahren ist.',
                  ),
                  SizedBox(height: 40),
                  LegendItem(
                    icon: Icons.elderly,
                    description: 'Es zeigt an, dass der Weg für ältere Menschen möglicherweise anspruchsvoll ist oder Hindernisse aufweisen kann.',
                  ),
                  SizedBox(height: 40),
                  LegendItem(
                    icon: Icons.stairs,
                    description:
                        'Es zeigt an, dass der Weg Stufen oder Treppen enthält und daher möglicherweise für Menschen mit eingeschränkter Mobilität schwierig ist.',
                  ),
                  SizedBox(height: 40),
                  LegendItem(
                    icon: Icons.elevator,
                    description:
                        'Es zeigt an, dass der Weg eine Rampe für Rollstuhlfahrer oder Personen mit Gehhilfen aufweist und somit leichter zugänglich ist.',
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Aktion ausführen, wenn der Notfall-Button gedrückt wird
            },
            backgroundColor: Colors.red,
            child: Text(
              'SOS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Positionieren Sie den Button in der Mitte unten
        );
      },
    );
  }
}

class LegendItem extends StatelessWidget {
  final IconData icon;
  final String description;

  const LegendItem({
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 60,
        ),
        SizedBox(width: 20), // Adjust the spacing between image and description
        Expanded(
            child: Text(
          description,
          softWrap: true,
        )),
      ],
    );
  }
}
