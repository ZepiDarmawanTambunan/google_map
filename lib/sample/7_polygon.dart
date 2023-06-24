// import 'dart:collection';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flt_map/firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:ui' as ui;

// import 'dart:async';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   // config
//   final Completer<GoogleMapController> _controller = Completer();
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(-1.643365, 103.605920),
//     zoom: 11,
//   );
//   Set<Polygon> _polygone = HashSet<Polygon>();
//   List<LatLng> points = [
//     LatLng(-1.550535, 103.650675), // start
//     LatLng(-1.559757, 103.654195),
//     LatLng(-1.564732, 103.648490),
//     LatLng(-1.567353, 103.649675),
//     LatLng(-1.582769, 103.638801),
//     LatLng(-1.587219, 103.643218),
//     LatLng(-1.587990, 103.643218),
//     LatLng(-1.602002, 103.640646),
//     LatLng(-1.588890, 103.652734),
//     LatLng(-1.609972, 103.656463),
//     LatLng(-1.617557, 103.680512),
//     LatLng(-1.649694, 103.660193),
//     LatLng(-1.664477, 103.626628),
//     LatLng(-1.653936, 103.558598),
//     LatLng(-1.628119, 103.542255),
//     LatLng(-1.628119, 103.542255),
//     LatLng(-1.590712, 103.537792),
//     LatLng(-1.570120, 103.549293),
//     LatLng(-1.584534, 103.593410),
//     LatLng(-1.571321, 103.600792),
//     LatLng(-1.549014, 103.647998),
//     LatLng(-1.550535, 103.650675), // end harus sama dengan start
//   ];

//   // secondary method
//   Future<Position> _getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) {
//       print('Error ' + error.toString());
//     });

//     return await Geolocator.getCurrentPosition();
//   }

//   // primary method
//   loadUserPosition() {
//     _getUserCurrentLocation().then(
//       (value) async {
//         CameraPosition currentCameraPosition = CameraPosition(
//           target: LatLng(value.latitude, value.longitude),
//           zoom: 11,
//         );

//         final GoogleMapController controller = await _controller.future;
//         controller.animateCamera(
//             CameraUpdate.newCameraPosition(currentCameraPosition));
//         setState(() {});
//       },
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadUserPosition();
//     _polygone.add(
//       Polygon(
//         polygonId: PolygonId('1'),
//         points: points,
//         fillColor: Colors.amber.withOpacity(0.3),
//         geodesic: true,
//         strokeWidth: 4,
//         strokeColor: Colors.redAccent,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           mapType: MapType.normal,
//           polygons: _polygone,
//           initialCameraPosition: _kGooglePlex,
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         ),
//       ),
//     );
//   }
// }
