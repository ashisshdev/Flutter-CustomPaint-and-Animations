// ignore_for_file: prefer_const_declarations, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

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
        home: Random());
  }
}

class Random extends StatefulWidget {
  const Random({super.key});

  @override
  State<Random> createState() => _RandomState();
}

class _RandomState extends State<Random>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RotationTransition(
          turns: animationController.view,
        ),
        // child: AnimatedBuilder(
        //     animation: animationController,
        //     builder: (context, child) {
        //       return SizedBox(
        //         height: 10 * animationController.value,
        //         child: child,
        //       );
        //     },
        //     child: Container(
        //       color: Colors.green,
        //     )),
      ),
    );
  }
}
