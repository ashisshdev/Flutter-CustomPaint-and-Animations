import 'package:flutter/material.dart';
import 'package:flutter_parallex/parallax_best.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'timesBold'),
      // home:ParallaxOne(),
      // home: const ParallaxTwoHorizontal(),
      // home: const ParallaxTwoVertical(),
      // home: const ParallaxThreeVertical(),
      // home: const ParallaxThreeHorizontal(),
      // home: const ParallaxFourHorizontal(),
      // home: const ParallaxFiveHorizontal(),
      home: const BestParallax(),
    );
  }
}
