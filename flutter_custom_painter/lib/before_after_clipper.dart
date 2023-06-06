import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// inspired from https://www.cutout.pro/

const String rawImage = 'assets/before_after/image_raw.jpg';
const String finalImage = 'assets/before_after/image_processed.png';

class _BeforeAfterState extends State<BeforeAfter> {
  double imageWidthValue = 160;
  double videoWidthValue = 190;

  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() async {
    videoPlayerController = VideoPlayerController.asset("dataSource");
    await videoPlayerController.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    super.initState();
  }

@override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: h * 0.4,
              width: w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                      left: 0,
                      child: Center(
                        child: SizedBox(
                          width: w * 0.95,
                          child: ClipPath(
                            clipper: ClipperFromRight(width: imageWidthValue),
                            child: Image.asset(
                              rawImage,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      )),
                  Positioned.fill(
                    child: Center(
                      child: SizedBox(
                          width: w * 0.95,
                          child: Image.asset(
                            finalImage,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          )),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        overlayShape: SliderComponentShape.noOverlay,
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        thumbShape: CustomSliderThumbShape(
                            sliderheight: h * 0.4, sliderwidth: imageWidthValue)),
                    child: Slider(
                      min: 0.0,
                      max: w * 0.95,
                      value: imageWidthValue,
                      onChanged: (value) {
                        setState(() {
                          imageWidthValue = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: h * 0.4,
              width: w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                      left: 0,
                      child: Center(
                        child: SizedBox(
                          width: w * 0.95,
                          child: ClipPath(
                            clipper: ClipperFromRight(width: videoWidthValue),
                            child: VideoPlayer(videoPlayerController),  
                          ),
                        ),
                      )),
                  Positioned.fill(
                    child: Center(
                      child: SizedBox(
                          width: w * 0.95,
                          child: Image.asset(
                            finalImage,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          )),
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        overlayShape: SliderComponentShape.noOverlay,
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        thumbShape: CustomSliderThumbShape(
                            sliderheight: h * 0.4, sliderwidth: videoWidthValue)),
                    child: Slider(
                      min: 0.0,
                      max: w * 0.95,
                      value: videoWidthValue,
                      onChanged: (value) {
                        setState(() {
                          videoWidthValue = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BeforeAfter extends StatefulWidget {
  const BeforeAfter({super.key});

  @override
  State<BeforeAfter> createState() => _BeforeAfterState();
}

class ClipperFromRight extends CustomClipper<Path> {
  final double width;

  ClipperFromRight({required this.width});
  @override
  getClip(Size size) {
    final w = width;
    final h = size.height;
    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double sliderheight;
  final double sliderwidth;

  CustomSliderThumbShape({
    required this.sliderheight,
    required this.sliderwidth,
    this.thumbRadius = 16.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final radius = thumbRadius;
    final paint = Paint()
      ..color = Colors.white60
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * 1,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      text: '< >',
    );

    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(center.dx - tp.width / 2, center.dy - tp.height / 2),
    );

    final linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    canvas.drawLine(
        Offset(sliderwidth + 10, 0), Offset(sliderwidth + 10, sliderheight), linePaint);
  }
}
