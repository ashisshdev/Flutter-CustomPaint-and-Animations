// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/particles_tunnel.dart';

void main() {
  // for waving flag
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Color(0xFFFF9933),
  //     systemNavigationBarColor: Color(0xFF138808)));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ParticlesTunnel());
  }
}
