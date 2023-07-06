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
  List<File> _selectedImages = [];
  List<Widget> _gridWidgets = [];

  Future<void> _setAddPictureWidget() async {
    setState(() {
      _gridWidgets.add(ClipRRect(
        child: Container(
          color: Colors.grey,
          child: const Column(children: [Text("Add"), Icon(Icons.add)]),
        ),
      ));
    });
  }

  Future<void> _takeImage() async {
    final imagePath = await context.push<String>('/createAnnotation/camera');
    if (imagePath != null) {
      setState(() {
        _selectedImages.add(File(imagePath));
      });
    }
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
            if (_gridWidgets.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                  ),
                  itemCount: _gridWidgets.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Access the image data using imageList[index]
                    // Here you can return a widget to display the image
                    return _gridWidgets.reversed.toList()[index];
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
