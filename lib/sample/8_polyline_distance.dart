// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flt_map/firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:ui' as ui;
// import 'package:maps_toolkit/maps_toolkit.dart' as mp;

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
//     zoom: 14.4746,
//   );
//   final Set<Polyline> _polyline = {};

//   // sample data
//   List<Marker> _marker = [];
//   final List<LatLng> _listLtLng = const [
//     LatLng(-1.6402679, 103.6003826),
//     // LatLng(-1.6411038, 103.6004302),
//     // LatLng(-1.616497, 103.5648949),
//     // LatLng(-1.6434716, 103.6001137),
//     LatLng(-1.6480879, 103.5996136),
//   ];
//   final distanceBetweenPoints = mp.SphericalUtil.computeDistanceBetween(
//       mp.LatLng(-1.6402679, 103.6003826), mp.LatLng(-1.6480879, 103.5996136));

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
//           zoom: 14.4746,
//         );

//         final GoogleMapController controller = await _controller.future;
//         controller.animateCamera(
//             CameraUpdate.newCameraPosition(currentCameraPosition));
//         setState(() {});
//       },
//     );
//   }

//   loadDataMarker() async {
//     for (int i = 0; i < _listLtLng.length; i++) {
//       _marker.add(
//         Marker(
//           markerId: MarkerId(i.toString()),
//           position: _listLtLng[i],
//           infoWindow: InfoWindow(
//             title: 'This is title marker ' + i.toString(),
//             snippet: '5 star Rating',
//           ),
//         ),
//       );
//     }

//     _polyline.add(
//       Polyline(
//         polylineId: PolylineId('1'),
//         points: _listLtLng,
//         color: Colors.redAccent,
//       ),
//     );
//     setState(() {});
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadUserPosition();
//     loadDataMarker();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(distanceBetweenPoints);
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GoogleMap(
//               markers: Set<Marker>.of(_marker),
//               mapType: MapType.normal,
//               polylines: _polyline,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//             Positioned(
//               bottom: 200,
//               left: 50,
//               child: Container(
//                   padding: EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Text(
//                       "Total Distance: " +
//                           distanceBetweenPoints.round().toString() +
//                           " M",
//                       style: TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold))),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
