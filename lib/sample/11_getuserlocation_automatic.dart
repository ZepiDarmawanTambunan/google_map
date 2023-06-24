// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:async';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() {
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
//   static LatLng sourceLoc = LatLng(-1.643365, 103.605920);
//   static CameraPosition kGooglePlex = CameraPosition(
//     target: sourceLoc,
//     zoom: 14.4746,
//   );
//   List<LatLng> polylineCoordinates = [];

//   // secondary method
//   Future<Position> _getUserCurrentLocation() async {
//     await Geolocator.requestPermission()
//         .then((value) {})
//         .onError((error, stackTrace) {a
//       print('Error ' + error.toString());
//     });

//     return await Geolocator.getCurrentPosition();
//   }

//   // primary method
//   loadUserPosition() {
//     _getUserCurrentLocation().then(
//       (value) async {
//         sourceLoc = LatLng(value.latitude, value.longitude);
//         kGooglePlex = CameraPosition(
//           target: sourceLoc,
//           zoom: 14.4746,
//         );
//         setState(() {});
//       },
//     );
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadUserPosition();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Maps'),
//       ),
//       body: SafeArea(
//         child: GoogleMap(
//           mapType: MapType.normal,
//           initialCameraPosition: kGooglePlex,
//           markers: {
//             Marker(
//               markerId: MarkerId('source'),
//               position: sourceLoc,
//             ),
//           },
//         ),
//       ),
//     );
//   }
// }
