import 'package:background/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import 'location_model.dart';
import 'map_provider.dart';

late LocationModel position;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Location().getLocation().then((value) {
    position = LocationModel(lat: value.latitude!, lng: value.longitude!);
  });
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => MapProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final _locationClient = LocationClient();
//   // final _mapController = MapController();
//   // final _points = <LatLng>[];
//   LatLng? currPosition;
//   bool _isServiceRunning = false;
//   final Location _location = Location();

//   Stream<LatLng> get locationStream => _location.onLocationChanged
//       .map((event) => LatLng(event.latitude!, event.longitude!));
//   @override
//   void initState() {
//     super.initState();
//     _locationClient.init();
//     _listenLocation();
//     //Timer.periodic(const Duration(seconds: 3), (_) => _listenLocation());
//   }

//   void _listenLocation() async {
//     if (!_isServiceRunning && await _locationClient.isServiceEnabled()) {
//       _isServiceRunning = true;
//       _location.onLocationChanged.listen((event) {
//         print(event);
//         setState(() {
//           currPosition = LatLng(event.latitude!, event.longitude!);
//         });
//         //_points.add(_currPosition!);
//       });
//     } else {
//       _isServiceRunning = false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//             title: const Text(
//           'Flutter background Locator',
//         )),
//         body: Container(
//           width: double.maxFinite,
//           padding: const EdgeInsets.all(22),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                // Text(currPosition.toString()),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
