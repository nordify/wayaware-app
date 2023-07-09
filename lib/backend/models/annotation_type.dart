import 'package:flutter/material.dart';
import 'package:wayaware/backend/annotations.dart';

enum AnnotationType {
  unknown,
  inaccessibleEntrances,
  lackOfElevators,
  limitedParkingSpaces,
  absenceOfRestroomAccessibility,
  lackOfVisualAccessibility,
  noHearingAssistance,
  unsupportiveSurfaces,
  stairsOnlyAccess,
  inaccessibleSeating,
  nonCompliantFacilities,
}

extension TypeExtensions on AnnotationType {
  String get typeName {
    switch (this) {
      case AnnotationType.inaccessibleEntrances:
        return "Inaccessible Entrances";
      case AnnotationType.lackOfElevators:
        return "Missing Elevators";
      case AnnotationType.limitedParkingSpaces:
        return "Limited Parking";
      case AnnotationType.absenceOfRestroomAccessibility:
        return "No Restrooms";
      case AnnotationType.lackOfVisualAccessibility:
        return "No visual accessibility";
      case AnnotationType.noHearingAssistance:
        return "No hearing assistance";
      case AnnotationType.unsupportiveSurfaces:
        return "Unsupportive Surfaces";
      case AnnotationType.stairsOnlyAccess:
        return "Stairs only";
      case AnnotationType.inaccessibleSeating:
        return "Inaccessible Seating";
      case AnnotationType.nonCompliantFacilities:
        return "Non compliant facilities";
      default:
        return "Select a type";
    }
  }

  double get typeColor {
    switch (this) {
      case AnnotationType.inaccessibleEntrances:
        return HSVColor.fromColor(Colors.red).hue;
      case AnnotationType.lackOfElevators:
        return HSVColor.fromColor(Colors.teal).hue;
      case AnnotationType.limitedParkingSpaces:
       return HSVColor.fromColor(Colors.amber).hue;
      case AnnotationType.absenceOfRestroomAccessibility:
        return HSVColor.fromColor(Colors.deepPurple).hue;
      case AnnotationType.lackOfVisualAccessibility:
        return HSVColor.fromColor(Colors.brown).hue;
      case AnnotationType.noHearingAssistance:
        return HSVColor.fromColor(Colors.lightBlue).hue;
      case AnnotationType.unsupportiveSurfaces:
        return HSVColor.fromColor(Colors.yellow).hue;
      case AnnotationType.stairsOnlyAccess:
        return HSVColor.fromColor(Colors.green).hue;
      case AnnotationType.inaccessibleSeating:
        return HSVColor.fromColor(Colors.deepOrange).hue;
      case AnnotationType.nonCompliantFacilities:
        return HSVColor.fromColor(Colors.lime).hue;
      default:
        return HSVColor.fromColor(Colors.white).hue;
    }
  }
}
