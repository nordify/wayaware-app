import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware/backend/models/annotation_type.dart';
import 'package:wayaware/bloc/user_settings_bloc.dart';

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
                      type: AnnotationType.absenceOfRestroomAccessibility,
                      description:
                          'Es zeigt an, dass es auf dem Weg möglicherweise Hindernisse gibt, die für Menschen mit Behinderungen eine Herausforderung darstellen könnten.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.stairsOnlyAccess,
                      description:
                          'Es zeigt an, dass der Weg Stufen oder Treppen enthält und daher möglicherweise für Menschen mit eingeschränkter Mobilität schwierig ist.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.lackOfElevators,
                      description:
                          'Es zeigt an, dass der Weg eine Rampe für Rollstuhlfahrer oder Personen mit Gehhilfen aufweist und somit leichter zugänglich ist.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.limitedParkingSpaces,
                      description:
                          'Es zeigt an, dass der Weg eine Rampe für Rollstuhlfahrer oder Personen mit Gehhilfen aufweist und somit leichter zugänglich ist.',
                    ),
                  ],
                ),
              ),
            ) // Positionieren Sie den Button in der Mitte unten
            );
      },
    );
  }
}

class LegendItem extends StatelessWidget {
  final AnnotationType type;
  final String description;

  const LegendItem({
    required this.type,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type.typeName,
          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/legend/${type.name.toLowerCase()}.png',
              height: 75,
            ),
            const SizedBox(width: 20), // Adjust the spacing between image and description
            Expanded(
                child: Text(
              description,
              softWrap: true,
            )),
          ],
        ),
      ],
    );
  }
}
