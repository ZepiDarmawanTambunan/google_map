// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flt_map/firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// import 'dart:async';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;

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
//   TextEditingController _controller = TextEditingController();
//   var uuid = Uuid();
//   String _sessionToken = '12343324';
//   List<dynamic> _placesList = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     _controller.addListener(() {
//       onChange();
//     });
//   }

//   void onChange() {
//     if (_sessionToken == null) {
//       _sessionToken = uuid.v4();
//     }
//     getSuggestion(_controller.text);
//   }

//   void getSuggestion(String input) async {
//     String kPLACES_API_KEY = 'AIzaSyDnaf8Snfrg51rSjE14v94VQmhTkg2OLxU';
//     String baseURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     String request =
//         '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

//     var response = await http.get(Uri.parse(request));

//     // print(response.body.toString());
//     // response = {
//     //   "predictions": [
//     //     {'descriptions': 'Jambi'},
//     //     {'descriptions': 'Jakarta'},
//     //     {'descriptions': 'Jayapura'},
//     //   ]
//     // }

//     if (response.statusCode == 200) {
//       setState(() {
//         // _placesList = jsonDecode(response.body.toString())['predictions'];
//         // karena places api perlu billing maka kita pakai dummy data saja
//         _placesList = [
//           {'descriptions': 'Jambi'},
//           {'descriptions': 'Jakarta'},
//           {'descriptions': 'Jayapura'},
//         ];
//       });
//     } else {
//       throw Exception('Error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Search'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: "Search places with name",
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _placesList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     onTap: () async {
//                       // jika pakai api
//                       List<Location> locations = await locationFromAddress(
//                           _placesList[index]['descriptions']);

//                       // dummy data
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             'Click ' +
//                                 _placesList[index]['descriptions'] +
//                                 "\n" +
//                                 locations.last.latitude.toString() +
//                                 "&" +
//                                 locations.last.longitude.toString(),
//                           ),
//                         ),
//                       );
//                     },
//                     title: Text(
//                       _placesList[index]['descriptions'],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
