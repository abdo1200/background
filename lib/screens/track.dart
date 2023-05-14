import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../map_provider.dart';

class TrackScreen extends StatefulWidget {
  const TrackScreen({super.key});

  @override
  State<TrackScreen> createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Reciver')),
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Consumer<MapProvider>(builder: (context, provider, child) {
            return provider.isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: GoogleMap(
                          markers: provider.markers,
                          polylines: {
                            Polyline(
                                polylineId: const PolylineId('value'),
                                points: provider.polyCoordinates)
                          },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(provider.current.latitude,
                                  provider.current.longitude),
                              zoom: 17),
                          onMapCreated: provider.onMapCreated,
                          myLocationEnabled: true,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Lat/Lng: ${position.lat}/ ${position.lng}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "updated = ${provider.updated} / retrived = ${provider.retrived}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
          }),
        ));
  }
}
