import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wayaware/backend/annotations.dart';
import 'package:wayaware/backend/models/annotation_type.dart';
import 'package:wayaware/utils/os_widgets.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:wayaware/backend/models/annotation.dart' as backend;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with AutomaticKeepAliveClientMixin<MapPage> {
  late final Future<Position?> getLocationFuture;
  late CameraPosition cameraPosition;

  late Uint8List testImgBytes;

  bool canLoadAnnotations = true;
  void startTimer() {
    Timer timer =
        Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      canLoadAnnotations = true;
    });
  }

  // ignore: unused_field
  List<Annotation> _annotations = [];
  Future<void> _loadAnnotations(CameraPosition pos) async {
    int deviceSizeConstant = 550;
    double minLatitude =
        pos.target.latitude - (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    double maxLatitude =
        pos.target.latitude + (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    double minLongitude =
        pos.target.longitude - (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    double maxLongitude =
        pos.target.longitude + (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    List<backend.Annotation> annotationObjects =
        (await Annotations.getAnnotations(
                amount: 100,
                minLatitude: minLatitude,
                maxLatitude: maxLatitude,
                minLongitude: minLongitude,
                maxLongitude: maxLongitude))
            .toList();

    List<Annotation> _newAnnotations = [];
    annotationObjects.forEach((element) {
      if (_annotations
          .map((e) => e.annotationId)
          .contains(AnnotationId(element.id))) return;
      print("test");
      Color annotationColor;
      _annotations.add(Annotation(
        annotationId: AnnotationId(element.id),
        position: LatLng(element.latitude, element.longitude),
        icon: BitmapDescriptor.markerAnnotationWithHue(HSVColor.fromColor(Colors.red).hue),
        onTap: () {},
      ));
    });
    //_annotations = _newAnnotations;
    _newAnnotations = [];
    setState(() {});
  }

  Future<Position?> _getCurrentLocation() async {
    testImgBytes = await getImageBytesFromAsset("assets/IMG_7265.JPG");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<Uint8List> getImageBytesFromAsset(String assetPath) async {
    ByteData byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    getLocationFuture = _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/app_icon_inverted.png',
          width: 75,
          height: 75,
        ),
      ),
      body: FutureBuilder(
          future: getLocationFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done ||
                snapshot.hasError) {
              return Center(
                child: OSWidgets.getCircularProgressIndicator(),
              );
            }

            return Stack(
              children: [
                AppleMap(
                    minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                    onCameraMove: (position) {
                      cameraPosition = position;
                    },
                    onCameraIdle: () {
                      _loadAnnotations(cameraPosition);
                    },
                    initialCameraPosition: CameraPosition(
                        target: LatLng(
                            snapshot.data!.latitude, snapshot.data!.longitude),
                        zoom: 14),
                    mapStyle: MapStyle.light,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    compassEnabled: false,
                    pitchGesturesEnabled: true,
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer(),
                      ),
                    },
                    annotations: _annotations.toSet()),
                Positioned.fromRect(
                  rect: Rect.fromLTRB(
                      MediaQuery.of(context).size.width * 19 / 20,
                      0,
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Positioned.fromRect(
                  rect: Rect.fromLTRB(
                      0,
                      0,
                      MediaQuery.of(context).size.width * 1 / 20,
                      MediaQuery.of(context).size.height),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
