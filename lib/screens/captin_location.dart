import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../map_provider.dart';

class CaptinLocation extends StatefulWidget {
  const CaptinLocation({super.key});

  @override
  State<CaptinLocation> createState() => _CaptinLocationState();
}

class _CaptinLocationState extends State<CaptinLocation> {
  late MapProvider mapProvider;

  @override
  void didChangeDependencies() {
    mapProvider = Provider.of<MapProvider>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    mapProvider.locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<MapProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Lat/Lng: ${position.lat}/ ${position.lng}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }));
  }
}
