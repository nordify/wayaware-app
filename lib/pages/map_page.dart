import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wayaware/utils/os_widgets.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final Future<Position?> getLocationFuture;

  late Uint8List testImgBytes;

  // ignore: unused_field
  final Set<Annotation> _annotations = {};
  /*Future<void> _loadAnnotations() async {
    for (final pictureId in _pictureCache) {
      final picture = await _loadPicture(pictureId);
      if (!mounted) return;
      final pictureBytes = await picture?.image?.bytes(160);

      if (pictureBytes == null || picture?.location == null) continue;

      // ignore: use_build_context_synchronously
      final annotation = Annotation(
          annotationId: AnnotationId(pictureId),
          onTap: () {},
          draggable: false,
          position: LatLng(picture?.location?.latitude ?? 0.0,
              picture?.location?.longitude ?? 0.0),
          icon: BitmapDescriptor.fromBytes(pictureBytes));
      _annotations.add(annotation);
    }
    setState(() {});
  }*/

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

            return AppleMap(
              initialCameraPosition: CameraPosition(
                  target:
                      LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  zoom: 14),
              mapStyle: MapStyle.light,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: false,
              pitchGesturesEnabled: true,
              annotations: {
                Annotation(
                    borderColor: Colors.blueAccent,
                    selectedBorderColor: Colors.blueAccent,
                    icon: BitmapDescriptor.fromBytes(testImgBytes),
                    annotationId: AnnotationId(
                      "test",
                    ),
                    position: LatLng(snapshot.data!.latitude + 0.0005,
                        snapshot.data!.longitude + 0.0005))
              },
            );
          }),
    );
  }
}