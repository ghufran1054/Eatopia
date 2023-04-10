import 'dart:developer';

import 'package:eatopia/utilities/colours.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng _center = const LatLng(0, 0);
  LatLng _markerLocation = const LatLng(0, 0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      // Location services are disabled, show an error message
      return;
    }

    // Check if the app has permission to access location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permission to access location is denied forever, show an error message
      return;
    }

    if (permission == LocationPermission.denied) {
      // Request permission to access location
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permission to access location is denied, show an error message
        return;
      }
    }

    // Get the user's current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _center = LatLng(position.latitude, position.longitude);
      _markerLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _markerLocation = position.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: appGreen,
            ),
            onPressed: () {},
            child: const Text(
              'Confirm Location',
              style: TextStyle(
                fontSize: 20,
              ),
            ))
      ],
      appBar: AppBar(
        title: const Text('Select your Location'),
        backgroundColor: appGreen,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onCameraMove: _onCameraMove,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 16.0),
            markers: {
              Marker(
                markerId: MarkerId('userLocation'),
                position: _markerLocation,
                // draggable: true,
                // onDragEnd: _onMarkerDragEnd,
              ),
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: FloatingActionButton(
              onPressed: () async {
                //Update the location move the camera to current location
                _getLocation();
                mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _center,
                      zoom: 16.0,
                    ),
                  ),
                );
              },
              backgroundColor: appGreen,
              child: const Icon(
                Icons.my_location,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
