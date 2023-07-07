import 'package:flutter/material.dart';
import 'package:wayaware/backend/models/annotation_type.dart';

class Annotation {
  final String id;
  final double altitude;
  final double latitude;
  final double longitude;
  final AnnotationType type;
  final String description;
  final List<ImageProvider> images;

  Annotation(this.id, this.altitude, this.latitude, this.longitude, this.type, this.description, this.images);
}
