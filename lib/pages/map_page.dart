import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            )),
        actions: [IconButton(onPressed: () => context.push('/settings'), icon: const Icon(Icons.settings))],
      ),
      body: const AppleMap(
        initialCameraPosition: CameraPosition(target: LatLng(53.508231, 9.999649), zoom: 14),
      ),
    );
  }
}
