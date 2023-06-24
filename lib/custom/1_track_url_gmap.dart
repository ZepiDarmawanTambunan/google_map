// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart' as loc;
// import 'package:location/location.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:math' show cos, sqrt, asin;

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
//   TextEditingController latController = TextEditingController();
//   TextEditingController lngController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter uber'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(
//               'Enter your destination',
//               style: TextStyle(fontSize: 40),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             TextField(
//               controller: latController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'latitude',
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextField(
//               controller: lngController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'longitute',
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               width: double.infinity,
//               child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => NavigationScreen(
//                             double.parse(latController.text),
//                             double.parse(lngController.text))));
//                   },
//                   child: Text('Get Directions')),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

// class NavigationScreen extends StatefulWidget {
//   final double lat;
//   final double lng;
//   NavigationScreen(this.lat, this.lng);

//   @override
//   State<NavigationScreen> createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> {
//   final Completer<GoogleMapController?> _controller = Completer();
//   Map<PolylineId, Polyline> polylines = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//   Location location = Location();
//   Marker? sourcePosition, destinationPosition;
//   loc.LocationData? _currentPosition;
//   LatLng curLocation = LatLng(-1.643365, 103.605920);
//   StreamSubscription<loc.LocationData>? locationSubscription;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getNavigation();
//     addMarker();
//   }

//   @override
//   void dispose() {
//     locationSubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: sourcePosition == null
//           ? Center(child: CircularProgressIndicator())
//           : Stack(
//               children: [
//                 GoogleMap(
//                   zoomControlsEnabled: false,
//                   polylines: Set<Polyline>.of(polylines.values),
//                   initialCameraPosition: CameraPosition(
//                     target: curLocation,
//                     zoom: 16,
//                   ),
//                   markers: {sourcePosition!, destinationPosition!},
//                   onTap: (latLng) {
//                     print(latLng);
//                   },
//                   onMapCreated: (GoogleMapController controller) {
//                     _controller.complete(controller);
//                   },
//                 ),
//                 Positioned(
//                   top: 30,
//                   left: 15,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).pushAndRemoveUntil(
//                           MaterialPageRoute(builder: (context) => MyApp()),
//                           (route) => false);
//                     },
//                     child: Icon(Icons.arrow_back),
//                   ),
//                 ),
//                 Positioned(
//                     bottom: 10,
//                     right: 10,
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.blue),
//                       child: Center(
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.navigation_outlined,
//                             color: Colors.white,
//                           ),
//                           onPressed: () async {
//                             await launchUrl(Uri.parse(
//                                 'google.navigation:q=${widget.lat}, ${widget.lng}&key=AIzaSyDnaf8Snfrg51rSjE14v94VQmhTkg2OLxU'));
//                           },
//                         ),
//                       ),
//                     ))
//               ],
//             ),
//     );
//   }

//   getNavigation() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     final GoogleMapController? controller = await _controller.future;
//     location.changeSettings(accuracy: loc.LocationAccuracy.high);
//     _serviceEnabled = await location.serviceEnabled();

//     // ask for permission
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//     if (_permissionGranted == loc.PermissionStatus.granted) {
//       // get current location
//       _currentPosition = await location.getLocation();
//       curLocation =
//           LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
//       // setiap kali lokasi berubah
//       locationSubscription =
//           location.onLocationChanged.listen((LocationData currentLocation) {
//         // start camera location disesuaikan dgn lokasi terkini
//         controller?.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target:
//                   LatLng(currentLocation.latitude!, currentLocation.longitude!),
//               zoom: 16,
//             ),
//           ),
//         );

//         if (mounted) {
//           // add marker
//           controller
//               ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
//           setState(() {
//             curLocation =
//                 LatLng(currentLocation.latitude!, currentLocation.longitude!);
//             sourcePosition = Marker(
//               markerId: MarkerId(currentLocation.toString()),
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueBlue),
//               position:
//                   LatLng(currentLocation.latitude!, currentLocation.longitude!),
//               infoWindow: InfoWindow(
//                   // jarak curPosition dengan destination
//                   title:
//                       '${double.parse((getDistance(LatLng(widget.lat, widget.lng)).toStringAsFixed(2)))} km'),
//               onTap: () {
//                 print('market tapped');
//               },
//             );
//           });
//           // membuat polylines
//           getDirections(LatLng(widget.lat, widget.lng));
//         }
//       });
//     }
//   }

//   getDirections(LatLng dst) async {
//     List<LatLng> polylineCoordinates = [
//       LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
//       dst,
//     ];
//     addPolyLine(polylineCoordinates);
//   }

//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.blue,
//       points: polylineCoordinates,
//       width: 5,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }

//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((lat2 - lat1) * p) / 2 +
//         c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//     return 12742 * asin(sqrt(a));
//   }

//   addMarker() {
//     setState(() {
//       sourcePosition = Marker(
//         markerId: MarkerId('source'),
//         position: curLocation,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
//       );
//       destinationPosition = Marker(
//         markerId: MarkerId('destination'),
//         position: LatLng(widget.lat, widget.lng),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
//       );
//     });
//   }

//   double getDistance(LatLng destposition) {
//     return calculateDistance(curLocation.latitude, curLocation.longitude,
//         destposition.latitude, destposition.longitude);
//   }
// }
