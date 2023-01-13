import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/wave_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            bottom: 0,
            child: SizedBox(
              height:
                  MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WaveAnimation(
                color: Colors.lightBlueAccent
                    .withOpacity(0.5),
              ),
            )),
        // Positioned(
        //     bottom: 0,
        //     child: SizedBox(
        //       height:
        //           MediaQuery.of(context).size.height,
        //       width: MediaQuery.of(context).size.width,
        //       child: WaveAnimation(
        //         color: Colors.blue.withOpacity(0.2),
        //         firstRiseStartMin: 1.2,
        //         secondRiseStartMax: 1.9,
        //         delay: 200,
        //       ),
        //     )),
        // Positioned(
        //     bottom: 0,
        //     child: SizedBox(
        //       height:
        //           MediaQuery.of(context).size.height,
        //       width: MediaQuery.of(context).size.width,
        //       child: WaveAnimation(
        //         color:
        //             Colors.lightBlue.withOpacity(0.5),
        //         firstRiseStartMax: 1.8,
        //         secondRiseStartMin: 1.4,
        //         delay: 400,
        //       ),
        //     )),
      ],
    ));
  }
}
