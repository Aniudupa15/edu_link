import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart' as osm;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late osm.MapController controller;
  osm.GeoPoint? currentLocation;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        currentLocation = osm.GeoPoint(
          latitude: position.latitude,
          longitude: position.longitude,
        );
        controller = osm.MapController(
          initPosition: currentLocation!,
          areaLimit: osm.BoundingBox(
            east: position.longitude + 0.001,
            north: position.latitude + 0.001,
            south: position.latitude - 0.001,
            west: position.longitude - 0.001,
          ),
        );
      });
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _checkUserLocation() async {
    osm.GeoPoint? userLocation = await controller.myLocation();
    if (userLocation != null) {
      bool isInArea = _isPointInBoundingBox(
        point: userLocation,
        box: controller.areaLimit!,
      );
      if (isInArea) {
        _updateAttendanceInFirestore();
        Fluttertoast.showToast(
          msg: "User is inside the specified location.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "User is outside the specified location.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 10,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
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
        fontSize: 16.0,
      );
    }
  }

  bool _isPointInBoundingBox(
      {required osm.GeoPoint point, required osm.BoundingBox box}) {
    return (point.latitude >= box.south &&
        point.latitude <= box.north &&
        point.longitude >= box.west &&
        point.longitude <= box.east);
  }

  Future<void> _updateAttendanceInFirestore() async {
    String? userId = FirebaseAuth.instance.currentUser!.email;
    DocumentReference userDoc =
    FirebaseFirestore.instance.collection('Attendance').doc(userId);

    // Check if the document exists
    bool documentExists =
    await userDoc.get().then((doc) => doc.exists);

    // If the document does not exist, create it
    if (!documentExists) {
      await userDoc.set({
        'totalClasses': 0,
        'classesAttended': 0,
        'attendancePercentage': 0.0,
      });
    }

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }

      int totalClasses = snapshot['totalClasses'] ?? 0;
      int classesAttended = snapshot['classesAttended'] ?? 0;
      double attendancePercentage = snapshot['attendancePercentage'] ?? 0.0;

      totalClasses += 1;
      classesAttended += 1;
      attendancePercentage = (classesAttended / totalClasses) * 100;

      transaction.update(userDoc, {
        'totalClasses': totalClasses,
        'classesAttended': classesAttended,
        'attendancePercentage': attendancePercentage,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          osm.OSMFlutter(
            controller: controller,
            osmOption: osm.OSMOption(
              userTrackingOption: const osm.UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: const osm.ZoomOption(
                initZoom: 100,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: osm.UserLocationMaker(
                personMarker: const osm.MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.green,
                    size: 100,
                  ),
                ),
                directionArrowMarker: const osm.MarkerIcon(
                  icon: Icon(
                    Icons.double_arrow,
                    size: 100,
                  ),
                ),
              ),
              roadConfiguration: const osm.RoadOption(
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
              child: const Text('Give Attendance'),
            ),
          ),
        ],
      ),
    );
  }
}
