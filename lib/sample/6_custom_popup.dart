// import 'dart:typed_data';

// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flt_map/firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/rendering.dart';
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
//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(-1.643365, 103.605920),
//     zoom: 14.4746,
//   );

//   // sample data
//   List<Marker> _marker = [];
//   final List<LatLng> _listLtLng = const [
//     LatLng(-1.6402679, 103.6003826),
//     LatLng(-1.6411038, 103.6004302),
//     LatLng(-1.616497, 103.5648949),
//     LatLng(-1.6434716, 103.6001137),
//     LatLng(-1.6480879, 103.5996136),
//   ];
//   final List<String> images = [
//     'assets/images/car.png',
//     'assets/images/car2.png',
//     'assets/images/motorcycle.png',
//     'assets/images/motorcycle2.png',
//     'assets/images/marker.png',
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
//       _marker.add(Marker(
//           markerId: MarkerId(i.toString()),
//           position: _listLtLng[i],
//           infoWindow: InfoWindow(
//             title: 'This is title marker ' + i.toString(),
//           ),
//           onTap: () {
//             _customInfoWindowController.addInfoWindow!(
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 300,
//                       height: 100,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage(images[1]),
//                           fit: BoxFit.fitWidth,
//                           filterQuality: FilterQuality.medium,
//                         ),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                         color: Colors.red,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         vertical: 10,
//                         horizontal: 20,
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             'Parkir Mobil Adit',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Tempat parkir mobil adit beroperasi selama 24jam. Dengan tarif Rp. 15.000/jam',
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               _listLtLng[i],
//             );
//           }));
//     }
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
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Custom info window example"),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GoogleMap(
//               markers: Set<Marker>.of(_marker),
//               mapType: MapType.normal,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _customInfoWindowController.googleMapController = controller;
//               },
//               onTap: (position) {
//                 _customInfoWindowController.hideInfoWindow!();
//               },
//               onCameraMove: (position) {
//                 _customInfoWindowController.onCameraMove!();
//               },
//             ),
//             CustomInfoWindow(
//               controller: _customInfoWindowController,
//               width: 300,
//               height: 200,
//               offset: 35,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
