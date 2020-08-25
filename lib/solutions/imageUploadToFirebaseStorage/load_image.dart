// import 'dart:math';

// import 'package:flutter/material.dart';
// //void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Firebase Storage Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LoadFirbaseStorageImage(),
//     );
//   }
// }

// final Color yellow = Color(0xfffbc31b);
// final Color orange = Color(0xfffb6900);
// final String image1 = "images/broccoli.jpg";
// final String image2 = "images/carrots.jpg";

// String image = image1;

// class LoadFirbaseStorageImage extends StatefulWidget {
//   @override
//   _LoadFirbaseStorageImageState createState() =>
//       _LoadFirbaseStorageImageState();
// }

// class _LoadFirbaseStorageImageState extends State<LoadFirbaseStorageImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             height: 360,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(50.0),
//                     bottomRight: Radius.circular(50.0)),
//                 gradient: LinearGradient(
//                     colors: [orange, yellow],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight)),
//           ),
//           Container(
//             margin: const EdgeInsets.only(top: 80),
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(
//                       "Loading image from Firebase Storage",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Expanded(
//                   child: Stack(
//                     children: <Widget>[
//                       Container(
//                         height: double.infinity,
//                         margin: const EdgeInsets.only(
//                             left: 30.0, right: 30.0, top: 10.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(30.0),
//                           child: FutureBuilder(
//                             future: _getImage(context, image),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.done)
//                                 return Container(
//                                   height:
//                                       MediaQuery.of(context).size.height / 1.25,
//                                   width:
//                                       MediaQuery.of(context).size.width / 1.25,
//                                   child: snapshot.data,
//                                 );

//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting)
//                                 return Container(
//                                     height: MediaQuery.of(context).size.height /
//                                         1.25,
//                                     width: MediaQuery.of(context).size.width /
//                                         1.25,
//                                     child: CircularProgressIndicator());

//                               return Container();
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 loadButton(context),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
