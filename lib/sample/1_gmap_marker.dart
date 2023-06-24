// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flt_map/firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

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
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(-1.643365, 103.605920),
//     zoom: 14.4746,
//   );

//   List<Marker> _marker = [];
//   final List<Marker> _list = const [
//     Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(-1.6402679, 103.6003826),
//       infoWindow: InfoWindow(
//         title: 'Apotek Diva',
//       ),
//     ),
//     Marker(
//       markerId: MarkerId('2'),
//       position: LatLng(-1.6411038, 103.6004302),
//       infoWindow: InfoWindow(
//         title: 'Apotek Ceria',
//       ),
//     ),
//     Marker(
//       markerId: MarkerId('3'),
//       position: LatLng(-1.616497, 103.5648949),
//       infoWindow: InfoWindow(
//         title: 'Apotek Kimia Farma',
//       ),
//     ),
//     Marker(
//       markerId: MarkerId('4'),
//       position: LatLng(-1.6434716, 103.6001137),
//       infoWindow: InfoWindow(
//         title: 'Apotek K24 Kenali Asam Bawah',
//       ),
//     ),
//     Marker(
//       markerId: MarkerId('5'),
//       position: LatLng(-1.6480879, 103.5996136),
//       infoWindow: InfoWindow(
//         title: 'Apotek Visi',
//       ),
//     ),
//   ];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _marker.addAll(_list);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: SafeArea(
//         child: GoogleMap(
//           zoomGesturesEnabled: false,
//           markers: Set<Marker>.of(_marker),
//           // compassEnabled: true,
//           // myLocationEnabled: true,
//           mapType: MapType.terrain,
//           initialCameraPosition: _kGooglePlex,
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.location_disabled_outlined),
//         onPressed: () async {
//           GoogleMapController controller = await _controller.future;
//           controller.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(-1.6402679, 103.6003826),
//                 zoom: 19,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
