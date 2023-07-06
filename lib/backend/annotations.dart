import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Annotations {

  Future<void> addAnnotation(Annotation annotation, List<String> pictureIds) async {
    
  }

  Future<String?> uploadPicture(File file) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      String id = const Uuid().v4();

      final imageRef = storageRef.child("images/$id");
      await imageRef.putFile(File(file.path));

      return id;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

}