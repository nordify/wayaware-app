import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatelessWidget {
  CameraPage({super.key});

  bool _pictureTaken = false;

  Future<String> _pathBuilder() async {
    final Directory extDir = await getTemporaryDirectory();
    final pictureDir = await Directory('${extDir.path}/wayaware').create(recursive: true);

    return '${pictureDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  Future<void> _startCameraStream(Stream<MediaCapture?> stream, BuildContext context) async {
    stream.listen((mediaCapture) {
      if (_pictureTaken) return;
      if (mediaCapture == null || !mediaCapture.isPicture) return;
      if (mediaCapture.status != MediaCaptureStatus.success) return;
      _pictureTaken = true;

      context.pop(mediaCapture.filePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CameraAwesomeBuilder.awesome(
        saveConfig: SaveConfig.photo(pathBuilder: _pathBuilder),
        sensor: Sensors.back,
        previewFit: CameraPreviewFit.cover,
        previewAlignment: Alignment.center,
        aspectRatio: CameraAspectRatios.ratio_4_3,
        // Buttons of CamerAwesome UI will use this theme
        theme: AwesomeTheme(
          bottomActionsBackgroundColor: Colors.black.withOpacity(0.5),
          buttonTheme: AwesomeButtonTheme(
            backgroundColor: Colors.black.withOpacity(0.5),
            iconSize: 20,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(16),
            buttonBuilder: (child, onTap) {
              return ClipOval(
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    splashColor: Colors.black,
                    highlightColor: Colors.black.withOpacity(0.5),
                    onTap: onTap,
                    child: child,
                  ),
                ),
              );
            },
          ),
        ),
        topActionsBuilder: (state) => AwesomeTopActions(
          padding: EdgeInsets.zero,
          state: state,
          children: const [],
        ),
        middleContentBuilder: (state) {
          _startCameraStream(state.captureState$, context);
          return Column(
            children: [
              const Spacer(),
              Builder(builder: (context) {
                return Container(
                  color: AwesomeThemeProvider.of(context).theme.bottomActionsBackgroundColor,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        "Take your best shot!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
        bottomActionsBuilder: (state) => AwesomeBottomActions(
          state: state,
          left: AwesomeFlashButton(
            state: state,
          ),
          right: AwesomeCameraSwitchButton(
            state: state,
            scale: 1.0,
            onSwitchTap: (state) {
              state.switchCameraSensor(
                aspectRatio: state.sensorConfig.aspectRatio,
              );
            },
          ),
        ),
        enablePhysicalButton: true,
      ),
    );
  }
}
