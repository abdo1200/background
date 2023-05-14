import 'package:background/screens/track.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../map_provider.dart';
import 'captin_location.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              onPressed: () {
                Provider.of<MapProvider>(context, listen: false)
                    .listenToPosition();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CaptinLocation(),
                    ));
              },
              child: const Text('start trip')),
          ElevatedButton(
              onPressed: () {
                Provider.of<MapProvider>(context, listen: false)
                    .realtimeUpdate();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrackScreen(),
                    ));
              },
              child: const Text('track')),
        ]),
      ),
    );
  }
}
