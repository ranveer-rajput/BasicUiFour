import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_4/page_one.model.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  List<OnboardingModel> pageList = [
    OnboardingModel(
        imgSrc: "assets/imgnew.png",
        text: "Fun around with \nIn your Favorite \nplace"),
    OnboardingModel(
        imgSrc: "assets/imgnewtwo.png",
        text: "Let's travel with \nUs and Enjoy \nyour trip"),
    OnboardingModel(
        imgSrc: "assets/imgnewthree.png",
        text: "Let's travel with \nUs and Enjoy \nyour trip"),
  ];

  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pageList.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset(
                        pageList[index].imgSrc,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Expanded(flex: 3, child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            pageList[index].text,
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              CustomPaint(
                                size: const Size(75, 75),
                                painter:
                                    CircleContainerPainter((index + 0.5) * 0.4),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (index == pageList.length) {
                                    // TODO: Navigate to homepage
                                  }

                                  pageController.animateToPage(
                                    index + 1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                iconSize: 32,
                                icon: const Icon(Icons.arrow_forward),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CircleContainerPainter extends CustomPainter {
  final double percentageCompleted;

  CircleContainerPainter(this.percentageCompleted);

  @override
  void paint(Canvas canvas, Size size) {
    const double strokeWidth = 4; // Set the desired border width here
    final double radius = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.white // Set your desired border color here
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - strokeWidth / 2, paint);

    final progressPaint = Paint()
      ..color = Colors.black // Set your desired progress color here
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressAngle = 2 * pi * percentageCompleted;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
