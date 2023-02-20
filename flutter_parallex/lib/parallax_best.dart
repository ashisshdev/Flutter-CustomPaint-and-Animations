import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_parallex/data.dart';

class BestParallax extends StatelessWidget {
  const BestParallax({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.green,
                height: 50,
                width: 300,
                margin: const EdgeInsets.all(30),
              ),
              Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const ParallaxWidget()),
              Container(
                color: Colors.red,
                height: 50,
                margin: const EdgeInsets.all(30),
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParallaxWidget extends StatefulWidget {
  const ParallaxWidget({super.key});

  @override
  State<ParallaxWidget> createState() => _ParallaxWidgetState();
}

class _ParallaxWidgetState extends State<ParallaxWidget> {
  late PageController pageController;
  bool pageHaveDimentions = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        pageHaveDimentions = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: const EdgeInsets.only(bottom: 30),
      child: PageView.builder(
          itemCount: myPaintings.length,
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, i) {
            return Transform.scale(
              scale: 1,
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                child: pageHaveDimentions
                    ? Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: AnimatedBuilder(
                                animation: pageController,
                                builder: (context, _) {
                                  return Image.asset(
                                    myPaintings[i].image,
                                    height: 330,
                                    fit: BoxFit.cover,
                                    alignment: Alignment(
                                        -pageController.page!.abs() +
                                            i,
                                        // gauss(-pageController.page!
                                        //         .abs()),
                                        0),
                                  );
                                },
                              )),
                          AnimatedBuilder(
                            animation: pageController,
                            child: Text(
                              myPaintings[i].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                    -pageController.page!.abs() * 5 +
                                        i,
                                    0.0),
                                child: child,
                              );
                            },
                          )
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            );
          }),
    );
  }
}

// caluclate Gaussian function
double gauss(offset) =>
    math.exp(-(math.pow((offset - 0.5), 2) / 0.08));
