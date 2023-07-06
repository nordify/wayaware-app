import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OSWidgets {
  static Widget getCircularProgressIndicator() {
    switch (Platform.operatingSystem) {
      case 'ios':
        return const CupertinoActivityIndicator();
      default:
        return Transform.scale(
            scale: 0.75, child: const CircularProgressIndicator());
    }
  }

  static Widget getSwitch(
      {required bool value, required Function(bool)? onChanged}) {
    switch (Platform.operatingSystem) {
      case 'ios':
        return CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: Color.fromRGBO(255, 144, 0, 1));
      default:
        return Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color.fromRGBO(255, 144, 0, 1));
    }
  }

  static Widget getLoadingPage() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: getCircularProgressIndicator(),
      ),
    );
  }
}
