import 'package:flutter/material.dart';
import 'package:flutter_parallex/data.dart';

class ParallaxFourHorizontal extends StatefulWidget {
  const ParallaxFourHorizontal({Key? key}) : super(key: key);

  @override
  State<ParallaxFourHorizontal> createState() =>
      _ParallaxFourHorizontalState();
}

class _ParallaxFourHorizontalState
    extends State<ParallaxFourHorizontal> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
  }

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
              height: 400,
              width: 350,
              child: PageView.builder(
                  itemCount: myMultiplePlaces.length,
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    // print(yesss[i].bg);
                    return Container(
                      color: Colors.green,
                      margin: const EdgeInsets.all(10),
                      // color: Colors.red,
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15))),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              bottom: 0,
                              child: Container(
                                height: MediaQuery.of(context)
                                    .size
                                    .height,
                                width:
                                    MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      myMultiplePlaces[i].bg
                                      //myMultiplePlaces[i].bg,
                                      ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment(
                                      pageOffset.abs() - i, 0.0),
                                )),
                                child: Image.asset(
                                  myMultiplePlaces[i].fg,
                                  fit: BoxFit.cover,
                                  // alignment: Alignment(
                                  //     -pageOffset.abs() + i, 0.0),
                                ),
                              ),
                            ),
                            Title(
                              name: myMultiplePlaces[i].name,
                            )
                          ],
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

class Title extends StatelessWidget {
  final String name;

  const Title({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 50,
      child: Container(
        height: 40,
        decoration:
            BoxDecoration(color: Colors.black.withOpacity(0.3)),
        child: Center(
          child: Text(
            name,
            textScaleFactor: 2.6,
            style: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
