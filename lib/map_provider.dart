import 'dart:async';

import 'package:background/location_client.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'location_model.dart';
import 'main.dart';

class MapProvider extends ChangeNotifier {
  LatLng current = LatLng(position.lat, position.lng);
  bool isloading = true;
  Set<Marker> markers = {};
  late GoogleMapController mapController;

  DatabaseReference lateRef = FirebaseDatabase.instance.ref("lat");
  DatabaseReference lngRef = FirebaseDatabase.instance.ref("lng");
  int updated = 0;
  int retrived = 0;

  List<LatLng> polyCoordinates = [];
  late BitmapDescriptor carIcon;

  MapProvider() {
    _getCurrentLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _getCurrentLocation() async {
    carIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
      'assets/bus.png',
    );
    addMarker("car location", LatLng(position.lat, position.lng), car: true);
    addMarker("end point", const LatLng(30.061521, 31.337483));
    getPolylines(PointLatLng(position.lat, position.lng),
        const PointLatLng(30.061521, 31.337483));
    isloading = false;
    notifyListeners();
  }

  addMarker(String id, LatLng position, {bool car = false}) {
    markers.add(
      Marker(
        markerId: MarkerId(id),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: 'Your $id',
        ),
        icon: car ? carIcon : BitmapDescriptor.defaultMarker,
      ),
    );
  }

  getPolylines(PointLatLng start, PointLatLng end) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBCjxNhoGVDe6YpbS_SoU-mtzXbQgvKxUA', start, end);
    if (result.points.isNotEmpty) {
      for (var pointLatLng in result.points) {
        polyCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      }
      notifyListeners();
    }
  }

  final _locationClient = LocationClient();
  LatLng currPosition = LatLng(position.lat, position.lng);
  final bool _isServiceRunning = false;
  final Location _location = Location();
  late StreamSubscription<LocationData> locationSubscription;

  realtimeUpdate() async {
    await updateCurrent();
    position = LocationModel(lat: current.latitude, lng: current.longitude);
    lateRef.onChildChanged.listen((event) {
      double lattt = double.parse(event.snapshot.value.toString());
      position = position.copyWith(lat: lattt);
      retrived = retrived + 1;

      markers = markers.map((marker) {
        if (marker.markerId.value == 'car location') {
          print('marker');
          return marker.copyWith(
              positionParam: LatLng(position.lat, position.lng));
        }
        return marker;
      }).toSet();
      // markers =
      //     updateMarker("car location", LatLng(position.lat, position.lng));
      notifyListeners();
      print('from lat');
    });
    lngRef.onChildChanged.listen((event) {
      double lngg = double.parse(event.snapshot.value.toString());
      position = position.copyWith(lng: lngg);

      retrived = retrived + 1;
      print(markers.first.markerId);

      markers = markers.map((marker) {
        if (marker.markerId.value == 'car location') {
          print('marker');
          return marker.copyWith(
              positionParam: LatLng(position.lat, position.lng));
        }
        return marker;
      }).toSet();
      notifyListeners();
      print('from long');
    });
  }

  updateCurrent() async {
    final valueRef = lateRef.child('lat');
    final valueSnapshot = await valueRef.once();
    final value = valueSnapshot.snapshot.value.toString();
    final lat = double.tryParse(value);
    final valueReflng = lngRef.child('ng');
    final valueSnapshotlng = await valueReflng.once();
    final valuelng = valueSnapshotlng.snapshot.value.toString();
    final lng = double.tryParse(valuelng);
    current = LatLng(lat!, lng!);
    markers = markers.map((marker) {
      if (marker.markerId.value == 'car location') {
        print('marker');
        return marker.copyWith(
            positionParam: LatLng(position.lat, position.lng));
      }
      return marker;
    }).toSet();
    final cameraUpdate = CameraUpdate.newLatLngZoom(
      current,
      16,
    );
    mapController.animateCamera(cameraUpdate);
    notifyListeners();
  }

  listenToPosition() async {
    _locationClient.init();
    locationSubscription = Location()
        .onLocationChanged
        .listen((LocationData currentLocation) async {
      currPosition =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      final latitude = currentLocation.latitude;
      final longitude = currentLocation.longitude;
      await lateRef.set({
        "lat": currentLocation.latitude,
      });
      await lngRef.set({
        "ng": currentLocation.longitude,
      });
      position = LocationModel(lat: latitude!, lng: longitude!);
      markers.first.copyWith(positionParam: LatLng(position.lat, position.lng));
      updated = updated + 1;
      notifyListeners();
    });
    // if (!_isServiceRunning && await _locationClient.isServiceEnabled()) {
    //   _isServiceRunning = true;
    //   _locationClient.locationStream.listen((event) async {
    //     currPosition = LatLng(event.latitude, event.longitude);
    //     final latitude = event.latitude;
    //     final longitude = event.longitude;
    //     await lateRef.set({
    //       "lat": event.latitude,
    //     });
    //     await lngRef.set({
    //       "ng": event.longitude,
    //     });
    //     position = LocationModel(lat: latitude, lng: longitude);
    //     markers.first
    //         .copyWith(positionParam: LatLng(position.lat, position.lng));
    //     updated = updated + 1;
    //     notifyListeners();
    //   });
    // } else {
    //   _isServiceRunning = false;
    // }
  }
}
