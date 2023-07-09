import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/backend/annotations.dart';
import 'package:wayaware/backend/leaderboard.dart';
import 'package:wayaware/backend/models/annotation.dart';
import 'package:wayaware/backend/models/annotation_type.dart';
import 'package:wayaware/bloc/auth_user_bloc.dart';
import 'package:wayaware/bloc/settings_mode_bloc.dart';
import 'package:wayaware/utils/os_widgets.dart';

class CreateAnnotationPage extends StatefulWidget {
  const CreateAnnotationPage({super.key});

  @override
  State<CreateAnnotationPage> createState() => _CreateAnnotationPageState();
}

class _CreateAnnotationPageState extends State<CreateAnnotationPage> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<File> _selectedImages = [];
  final List<Widget> _gridWidgets = [];
  int _selectedType = 0;
  bool _isLoading = false;

  Future<void> _toggleLoading() async {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

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
    HapticFeedback.mediumImpact();
    List<String> imageIds = [];
    _toggleLoading();

    if (_selectedImages.isEmpty) {
      _showErrorAlert('You have to take at least one picture of the location!');
      return;
    }

    if (_textFieldController.text.length < 50) {
      _showErrorAlert('Your description is too short! Please add some more information.');
      return;
    }

    if (_selectedType == 0) {
      _showErrorAlert('You have to select a type to create an annotation!');
      return;
    }

    for (final imageFile in _selectedImages) {
      final imageId = await Annotations.uploadImage(imageFile);
      if (imageId == null) continue;
      imageIds.add(imageId);
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, timeLimit: const Duration(seconds: 8));

    await Annotations.addAnnotation(AnnotationType.values[_selectedType].name, _textFieldController.text, position, imageIds);

    if (!mounted) return;
    final authUserBloc = context.read<AuthUserBloc>();
    await LeaderBoard.saveUserPoints(authUserBloc, points: Random().nextInt(8) + 3);

    _showSuccessAlert();
    _toggleLoading();
  }

  Future<void> _showDialog(Widget child) async {
    HapticFeedback.mediumImpact();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  Future<void> _showErrorAlert(String errorMessage) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _toggleLoading();
    HapticFeedback.heavyImpact();
    if (!mounted) return;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Error!'),
          content: Text(errorMessage),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSuccessAlert() async {
    HapticFeedback.heavyImpact();
    if (!mounted) return;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Success!'),
          content: const Text('The annotation was successfully created'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the alert dialog
                context.pop();
              },
            ),
          ],
        );
      },
    );
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
    return BlocBuilder<UserSettingsBloc, Map<String, bool>>(
      builder: (context, state) {
        final accessibilityMode = state['accessibility_mode'] ?? false;

        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          backgroundColor: Colors.white,
          appBar: AppBar(
              elevation: 0,
              toolbarHeight: 80,
              backgroundColor: Colors.black,
              title: Row(
                children: [
                  const Text(
                    "Create Annotation",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  SizedBox(
                      height: 60,
                      child: Image.asset(
                        "assets/app_icon_inverted.png",
                      )),
                ],
              )),
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                onPressed: !_isLoading ? _saveAnnotation : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: !_isLoading
                    ? const Text("Save", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                    : OSWidgets.getCircularProgressIndicator(),
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Whats the topic?',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () => _showDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 32.0,
                          // This sets the initial item.
                          scrollController: FixedExtentScrollController(
                            initialItem: _selectedType,
                          ),
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            setState(() {
                              _selectedType = selectedItem;
                            });
                          },
                          children: List<Widget>.generate(AnnotationType.values.length, (int index) {
                            return Center(child: Text(AnnotationType.values[index].typeName));
                          }),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      child: Text(
                        AnnotationType.values[_selectedType].typeName,
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Describe the location',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  const SizedBox(height: 8.0),
                  CupertinoTextField(
                    placeholder: 'Enter your description',
                    controller: _textFieldController,
                    maxLines: 3,
                    autofocus: false,
                    onSubmitted: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                    onEditingComplete: () => FocusManager.instance.primaryFocus?.unfocus(),
                  ),

                  /*DropdownButtonFormField<String>(
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
                  ), */
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
