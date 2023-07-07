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
}
