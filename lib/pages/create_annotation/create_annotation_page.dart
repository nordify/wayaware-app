import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/backend/annotations.dart';
import 'package:wayaware/backend/models/annotation.dart';

class CreateAnnotationPage extends StatefulWidget {
  const CreateAnnotationPage({super.key});

  @override
  State<CreateAnnotationPage> createState() => _CreateAnnotationPageState();
}

class _CreateAnnotationPageState extends State<CreateAnnotationPage> {
  final TextEditingController _textFieldController = TextEditingController();
  List<File> _selectedImages = [];
  List<Widget> _gridWidgets = [];
  String _selectedType = "";

  Future<void> _setAddPictureWidget() async {
    setState(() {
      _gridWidgets.add(GestureDetector(
        onTap: _takeImage,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            color: Colors.grey.shade400,
            child: const Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(height: 5),
              Text(
                "Add Picture",
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600),
              )
            ]),
          ),
        ),
      ));
    });
  }

  Future<void> _takeImage() async {
    HapticFeedback.heavyImpact();
    final imagePath = await context.push<String>('/createAnnotation/camera');
    if (imagePath != null) {
      final imageFile = File(imagePath);
      setState(() {
        _gridWidgets.add(ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            )));
        _selectedImages.add(imageFile);
      });
    }
  }

  Future<void> _saveAnnotation() async {
    List<String> imageIds = [];

    for (final imageFile in _selectedImages) {
      final imageId = await Annotations.uploadImage(imageFile);
      if (imageId == null) continue;
      imageIds.add(imageId);
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, timeLimit: const Duration(seconds: 8));

    await Annotations.addAnnotation(_selectedType, _textFieldController.text, position, imageIds);
  }

  @override
  void initState() {
    _setAddPictureWidget();
    super.initState();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textFieldController,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Enter text',
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: AnnotationType.values.first.name,
              items: AnnotationType.values.map((AnnotationType item) {
                return DropdownMenuItem<String>(
                  value: item.name,
                  child: Text(item.name),
                );
              }).toList(),
              onChanged: (String? selectedValue) {
                if (selectedValue != null) {
                  _selectedType = selectedValue;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Select item',
              ),
            ),
            const SizedBox(height: 16.0),
            if (_gridWidgets.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 7.5),
                  itemCount: _gridWidgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _gridWidgets.reversed.toList()[index];
                  },
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                onPressed: _saveAnnotation,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
