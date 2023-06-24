// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flt_map/firebase_options.dart';
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

//   Future<Uint8List?> loadNetWorkImage(String path) async {
//     final completer = Completer<ImageInfo>();
//     var image = NetworkImage(path);

//     image.resolve(ImageConfiguration()).addListener(
//         ImageStreamListener((info, _) => completer.complete(info)));

//     final imageInfo = await completer.future;
//     final byteData =
//         await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
//     return byteData!.buffer.asUint8List();
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
//       Uint8List? image =
//           await loadNetWorkImage('https://picsum.photos/250?image=9');
//       final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
//         image!.buffer.asUint8List(),
//         targetHeight: 100,
//         targetWidth: 100,
//       );

//       final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
//       final ByteData? byteData = await frameInfo.image.toByteData(
//         format: ui.ImageByteFormat.png,
//       );

//       final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

//       _marker.add(Marker(
//         markerId: MarkerId(i.toString()),
//         position: _listLtLng[i],
//         icon: BitmapDescriptor.fromBytes(resizedImageMarker),
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
