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
//   Uint8List? markerImage;
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(-1.643365, 103.605920),
//     zoom: 14.4746,
//   );

//   // sample data
//   List<Marker> _marker = [];
//   List<String> images = [
//     'assets/images/car.png',
//     'assets/images/car2.png',
//     'assets/images/motorcycle.png',
//     'assets/images/motorcycle2.png',
//     'assets/images/marker.png',
//   ];
//   final List<LatLng> _listLtLng = const [
//     LatLng(-1.6402679, 103.6003826),
//     LatLng(-1.6411038, 103.6004302),
//     LatLng(-1.616497, 103.5648949),
//     LatLng(-1.6434716, 103.6001137),
//     LatLng(-1.6480879, 103.5996136),
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

//   Future<Uint8List> getBytesFromAssets(String path, int height) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(
//       data.buffer.asUint8List(),
//       targetHeight: height,
//     );
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
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
//     for (int i = 0; i < images.length; i++) {
//       final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
//       _marker.add(Marker(
//         markerId: MarkerId(i.toString()),
//         position: _listLtLng[i],
//         icon: BitmapDescriptor.fromBytes(markerIcon),
//         infoWindow: InfoWindow(
//           title: 'This is title marker ' + i.toString(),
//         ),
//       ));
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
//       body: SafeArea(
//         child: GoogleMap(
//           markers: Set<Marker>.of(_marker),
//           mapType: MapType.normal,
//           initialCameraPosition: _kGooglePlex,
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//         ),
//       ),
//     );
//   }
// }
