import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart' as cache;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:wayaware/backend/models/annotation.dart';

class Annotations {
  // The URL for accessing the Firebase Storage
  static final storageUrl = "gs://${FirebaseStorage.instance.app.options.storageBucket}";

  static Future<bool> addAnnotation(String type, String desc, Position position, List<String> imageIds) async {
    final id = const Uuid().v4();

    FirebaseFirestore.instance.collection('annotations').doc(id).set({
      'id': id,
      'type': type,
      'description': desc,
      'altitude': position.altitude,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'images': imageIds
    });

    return true;
  }

  static Future<String?> uploadImage(File file) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final id = const Uuid().v4();

      final imageRef = storageRef.child("images/$id");
      await imageRef.putFile(File(file.path));

      return id;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  static Future<Annotation?> getAnnotation(String annotationId) async {
    final data = await FirebaseFirestore.instance.collection('annotations').doc(annotationId).get();
    if (data.data() == null || data.data()!.isEmpty) return null;

    final List<ImageProvider> images = [];
    for (final imageId in data.data()!['images']) {
      images.add(_getImageFromStorage(imageId));
    }

    return Annotation(annotationId, data.data()!['altitude'], data.data()!['latitude'], data.data()!['longitude'], AnnotationType.values.firstWhere((element) => element.toString().split('.').last == data.data()!['type']),
        data.data()!['description'], images);
  }

  static ImageProvider _getImageFromStorage(String imageId, {reloadPicture = false}) {
    return cache.FirebaseImageProvider(cache.FirebaseUrl("$storageUrl/images/$imageId"),
        options: cache.CacheOptions(metadataRefreshInBackground: !reloadPicture, checkForMetadataChange: reloadPicture));
  }
}
