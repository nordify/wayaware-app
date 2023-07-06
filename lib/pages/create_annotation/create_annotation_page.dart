import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/backend/models/annotation.dart';

class CreateAnnotationPage extends StatefulWidget {
  const CreateAnnotationPage({super.key});

  @override
  State<CreateAnnotationPage> createState() => _CreateAnnotationPageState();
}

class _CreateAnnotationPageState extends State<CreateAnnotationPage> {
  final TextEditingController _textFieldController = TextEditingController();
  List<Image> selectedImages = [];

  Future<void> _takeImage() async {
    final imagePath = await context.push<String>('/createAnnotation/camera');
    if (imagePath != null) {
      setState(() {
        selectedImages.add(Image.file(File(imagePath)));
      });
    }
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
                  setState(() {
                    // Do something with the selected value
                  });
                }
              },
              decoration: const InputDecoration(
                labelText: 'Select item',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _takeImage,
              child: const Text('Add Images'),
            ),
            const SizedBox(height: 16.0),
            if (selectedImages.isNotEmpty)
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: selectedImages,
              ),
          ],
        ),
      ),
    );
  }
}
