import 'package:flutter/material.dart';

import 'data.dart';

class ParallaxTwoHorizontal extends StatefulWidget {
  const ParallaxTwoHorizontal({Key? key}) : super(key: key);

  @override
  State<ParallaxTwoHorizontal> createState() =>
      _ParallaxTwoHorizontalState();
}

class _ParallaxTwoHorizontalState
    extends State<ParallaxTwoHorizontal> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/paintings/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 30),
                  Text(
                    'Vincent\nvan Gogh',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '30 March 1853-29 July 1890',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Vincent Willem van Gogh was a Dutch post-impressionist painter who posthumously became one of the most famous and influential figures in the history of Western art.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  child: Text(
                    'Highlight Paintings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  padding: const EdgeInsets.only(bottom: 30),
                  child: PageView.builder(
                      itemCount: myPaintings.length,
                      controller: pageController,
                      itemBuilder: (context, i) {
                        return Transform.scale(
                          scale: 1,
                          child: Container(
                            padding: const EdgeInsets.only(right: 20),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(15),
                                  child: Image.asset(
                                    myPaintings[i].image,
                                    height: 370,
                                    fit: BoxFit.cover,
                                    alignment: Alignment(
                                        -pageOffset.abs() + i, 0),
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  bottom: 20,
                                  right: 10,
                                  child: Transform.translate(
                                    offset: Offset(
                                        -pageOffset.abs() + i, 0),
                                    child: Text(
                                      myPaintings[i].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Parallax using pageView but vertical

class ParallaxTwoVertical extends StatefulWidget {
  const ParallaxTwoVertical({Key? key}) : super(key: key);

  @override
  State<ParallaxTwoVertical> createState() =>
      _ParallaxTwoVerticalState();
}

class _ParallaxTwoVerticalState extends State<ParallaxTwoVertical> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.4);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
              height: 600,
              width: 350,
              child: PageView.builder(
                  itemCount: myPlacesVertical.length,
                  controller: pageController,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                        child: Image.asset(
                          myPlacesVertical[i].image,
                          fit: BoxFit.cover,
                          alignment:
                              Alignment(0, pageOffset.abs() - i),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
