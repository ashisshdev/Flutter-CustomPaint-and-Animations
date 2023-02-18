import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parallex/data.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ParallaxFiveHorizontal extends StatelessWidget {
  const ParallaxFiveHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                'Travel the world',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: 350,
                child: MyParallaxCarousel(
                  foregroundImages: List.generate(
                      myMultiplePlaces.length,
                      (index) => myMultiplePlaces[index].fg),
                  backgroundImages: List.generate(
                      myMultiplePlaces.length,
                      (index) => myMultiplePlaces[index].bg),
                )),
          ],
        ),
      ),
    );
  }
}

class MyParallaxCarousel extends StatefulWidget {
  final List<String> foregroundImages;
  final List<String> backgroundImages;

  const MyParallaxCarousel(
      {super.key,
      required this.foregroundImages,
      required this.backgroundImages});

  @override
  State<MyParallaxCarousel> createState() =>
      _MyParallaxCarouselState();
}

class _MyParallaxCarouselState extends State<MyParallaxCarousel> {
  double? _accelerometerXAxis;
  StreamSubscription<dynamic>? accelerometerListener;
  late final List<String> foregroundImages;
  late final List<String> backgroundImages;

  @override
  void initState() {
    super.initState();
    foregroundImages = widget.foregroundImages;
    backgroundImages = widget.backgroundImages;
    accelerometerListener = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          _accelerometerXAxis = event.x;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerListener?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.5,
        viewportFraction: 0.95,
        enableInfiniteScroll: false,
      ),
      items: [
        for (int i = 0; i < foregroundImages.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    right: _accelerometerXAxis != null
                        ? (-350 + _accelerometerXAxis! * 30)
                        : -350,
                    left: _accelerometerXAxis != null
                        ? (-350 + _accelerometerXAxis! * 30)
                        : -350,
                    top: _accelerometerXAxis != null
                        ? (-350 + _accelerometerXAxis! * 30)
                        : -350,
                    bottom: _accelerometerXAxis != null
                        ? (-350 + _accelerometerXAxis! * 30)
                        : -350,
                    child: Image.asset(
                      backgroundImages[i],
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    width: 320,
                    bottom: 0,
                    right: _accelerometerXAxis != null
                        ? (-13 + _accelerometerXAxis! * 1.5)
                        : -13,
                    child: Image.asset(
                      foregroundImages[i],
                      fit: BoxFit.fill,
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     const SizedBox(height: 60),
                  //     Text(
                  //       'FEATURED',
                  //       style: GoogleFonts.roboto(
                  //         color: Colors.white,
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w300,
                  //         letterSpacing: 1,
                  //       ),
                  //     ),
                  //     Text(
                  //       _texts[index], //GabrielaStencil
                  //       style: GoogleFonts.gabriela(
                  //         color: Colors.white,
                  //         fontSize: 55,
                  //         fontWeight: FontWeight.w600,
                  //         letterSpacing: 1,
                  //       ),
                  //     ),
                  //     const SizedBox(height: 16),
                  //   ],
                  // )
                ],
              ),
            ),
          )
        ]
      ],
    );
  }
}
