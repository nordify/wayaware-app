import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:wayaware/backend/annotations.dart';
import 'package:wayaware/backend/models/annotation_type.dart';
import 'package:wayaware/pages/photo_view.dart';
import 'package:wayaware/utils/os_widgets.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:wayaware/backend/models/annotation.dart' as backend;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin<MapPage> {
  late final Future<Position?> getLocationFuture;
  late CameraPosition cameraPosition;

  late Uint8List testImgBytes;

  backend.Annotation? selectedAnnotation;

  PanelController panelController = PanelController();

  bool canLoadAnnotations = true;
  void startTimer() {
    Timer timer = Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      canLoadAnnotations = true;
    });
  }

  // ignore: unused_field
  List<Annotation> _annotations = [];
  List<backend.Annotation> annotationObjects = [];
  Future<void> _loadAnnotations(CameraPosition pos) async {
    int deviceSizeConstant = 550;
    double minLatitude = pos.target.latitude - (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    double maxLatitude = pos.target.latitude + (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    double minLongitude = pos.target.longitude - (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    double maxLongitude = pos.target.longitude + (1 / pow(2, pos.zoom) * deviceSizeConstant) / 2;
    annotationObjects = (await Annotations.getAnnotations(
            amount: 100, minLatitude: minLatitude, maxLatitude: maxLatitude, minLongitude: minLongitude, maxLongitude: maxLongitude))
        .toList();

    annotationObjects.forEach((element) {
      if (_annotations.map((e) => e.annotationId).contains(AnnotationId(element.id))) return;
      _annotations.add(Annotation(
        annotationId: AnnotationId(element.id),
        position: LatLng(element.latitude, element.longitude),
        icon: BitmapDescriptor.markerAnnotationWithHue(element.type.typeColor),
        onTap: () {
          setState(() {
            selectedAnnotation = annotationObjects.where((annotation) => annotation.id == element.id).first;
          });
          panelController.open();
        },
      ));
    });
    //_annotations = _newAnnotations;
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
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
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
      body: SlidingUpPanel(
        onPanelClosed: () {
          selectedAnnotation == null;
        },
        backdropTapClosesPanel: true,
        backdropEnabled: true,
        controller: panelController,
        minHeight: 0,
        parallaxEnabled: true,
        parallaxOffset: 0.3,
        borderRadius: BorderRadius.circular(15),
        panel: SingleChildScrollView(
          child: Column(
            children: [
              if (selectedAnnotation != null)
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Builder(
                    builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedAnnotation!.type.typeName,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            selectedAnnotation!.description,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: List.generate(
                                selectedAnnotation!.images.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            return PhotoViewer(image: selectedAnnotation!.images[index]);
                                          },
                                        ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Image(image: selectedAnnotation!.images[index]),
                                        ),
                                      ),
                                    )),
                          )
                        ],
                      );
                    },
                  ),
                ),
              const SizedBox(
                height: 90,
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            FutureBuilder(
                future: getLocationFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done || snapshot.hasError) {
                    return Center(
                      child: OSWidgets.getCircularProgressIndicator(),
                    );
                  }
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: AppleMap(
                            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                            onCameraMove: (position) {
                              cameraPosition = position;
                            },
                            onCameraIdle: () {
                              _loadAnnotations(cameraPosition);
                            },
                            onMapCreated: (controller) {
                              _loadAnnotations(CameraPosition(target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude)));
                            },
                            initialCameraPosition: CameraPosition(target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude), zoom: 14),
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
                      ),
                      Positioned.fromRect(
                        rect: Rect.fromLTRB(
                            MediaQuery.of(context).size.width * 19 / 20, 0, MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                      Positioned.fromRect(
                        rect: Rect.fromLTRB(0, 0, MediaQuery.of(context).size.width * 1 / 20, MediaQuery.of(context).size.height),
                        child: Container(
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
