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
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: accessibilityMode ? 40 : 20),
                )),
            body: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 40,
                    bottom: 100), // Adjust the bottom padding
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LegendItem(
                      type: AnnotationType.absenceOfRestroomAccessibility,
                      description:
                          'The "Absence of Restroom Accessibility" symbol is a universal graphical representation commonly used to indicate the absence of restroom facilities or the unavailability of public toilets in a specific area.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.stairsOnlyAccess,
                      description:
                          '"Stairs Only Access" is a symbol commonly used to indicate that only stairs should be used for vertical movement, and no other means of transportation such as elevators or escalators are available or permitted.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.lackOfElevators,
                      description:
                          'The symbol "Lack of Elevators" represents a situation where elevators are not available or out of service in a specific location or building.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.lackOfVisualAccessibility,
                      description:
                          '"Lack of visual accessibility" is a symbol that represents the absence or lack of visual accessibility. It signifies that a particular place, object, or service may not be easily accessible or usable for individuals who are visually impaired or have visual disabilities.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.noHearingAssistance,
                      description:
                          'The symbol "No hearing assistance" is a visual representation used to indicate that there is no availability of hearing aids or assistance devices in a particular area or situation.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.unsupportiveSurfaces,
                      description:
                          'The symbol "Unsupportive Surfaces" depicts a pictogram that represents surfaces or structures that are not suitable for supporting weight or providing stability.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.inaccessibleSeating,
                      description:
                          'The symbol for "Inaccessible Seating" is used to indicate seating areas that are not easily accessible to individuals with disabilities.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.nonCompliantFacilities,
                      description:
                          '"Non-compliant facilities" refer to buildings or establishments that do not meet the necessary regulatory or industry standards.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.inaccessibleEntrances,
                      description:
                          'The symbol "Inaccessible Entrances" is used to denote entrances or access points that are not accessible to individuals with disabilities or mobility impairments.',
                    ),
                    SizedBox(height: 40),
                    LegendItem(
                      type: AnnotationType.limitedParkingSpaces,
                      description:
                          '"Limited Parking Spaces" is a symbol used to indicate restrictions on parking availability or duration in a specific area.',
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
    return BlocBuilder<UserSettingsBloc, Map<String, bool>>(
        builder: (context, state) {
      final accessibilityMode = state['accessibility_mode'] ?? false;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type.typeName,
            style: TextStyle(
                color: Colors.black,
                fontSize: accessibilityMode ? 30 : 20,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/legend/${type.name.toLowerCase()}.png',
                height: accessibilityMode ? 55 : 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                description,
                style: TextStyle(fontSize: accessibilityMode ? 20 : 15),
                softWrap: true,
              )),
            ],
          ),
        ],
      );
    });
  }
}
