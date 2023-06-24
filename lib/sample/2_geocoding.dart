// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flt_map/firebase_options.dart';
// import 'package:geocoding/geocoding.dart';

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
//       home: const HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }

// class HomeScreenState extends State<HomeScreen> {
//   String stAdress = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gmap'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(stAdress),
//           GestureDetector(
//             onTap: () async {
//               List<Placemark> placemarks =
//                   await placemarkFromCoordinates(52.2165157, 6.9437819);

//               List<Location> locations =
//                   await locationFromAddress('Tugu Keris Jambi');

//               print(placemarks);
//               setState(() {
//                 stAdress = placemarks.last.street.toString() +
//                     "\n" +
//                     locations.last.latitude.toString() +
//                     "&" +
//                     locations.last.longitude.toString();
//               });
//             },
//             child: Padding(
//               padding: EdgeInsets.all(8),
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: Colors.greenAccent,
//                 ),
//                 child: Center(
//                   child: Text('Convert'),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
