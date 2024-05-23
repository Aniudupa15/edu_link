import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController controller = MapController(
    initPosition: GeoPoint(latitude: 12.907287, longitude: 74.866213),
    areaLimit: BoundingBox(
      east: 74.8663045,
      north: 12.9073768,
      south: 12.9071972,
      west: 74.8661215,
    ),
  );

  @override
  void dispose() {
    super.dispose();
  }

  void _checkUserLocation() async {
    GeoPoint? currentLocation = await controller.myLocation();
    if (currentLocation != null) {
      bool isInArea = _isPointInBoundingBox(
        point: currentLocation,
        box: controller.areaLimit!,
      );
      if (isInArea) {
        Fluttertoast.showToast(
            msg: "User is inside the specified location.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 10.0
        );
      } else {
        Fluttertoast.showToast(
            msg: "User is outside the specified location.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 10.0
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: "Could not determine user location.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 10.0
      );
    }
  }

  bool _isPointInBoundingBox({required GeoPoint point, required BoundingBox box}) {
    return (point.latitude >= box.south &&
        point.latitude <= box.north &&
        point.longitude >= box.west &&
        point.longitude <= box.east);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page'),
      ),
      body: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            osmOption: OSMOption(
              userTrackingOption: const UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: const ZoomOption(
                initZoom: 100,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
                directionArrowMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 100,
                  ),
                ),
              ),
              roadConfiguration: const RoadOption(
                roadColor: Colors.yellowAccent,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _checkUserLocation,
              child: const Text('Check Location'),
            ),
          ),
        ],
      ),
    );
  }
}