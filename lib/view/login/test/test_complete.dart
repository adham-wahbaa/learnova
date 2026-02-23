import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/test_description.dart';

class TestCompleteScreen extends StatelessWidget {
  final int testIndex;

  const TestCompleteScreen({super.key, required this.testIndex});

  static const List<Map<String, dynamic>> results = [
    {
      'title': 'Cognitive Test',
      'result': 'Astute',
      'icon': 'assets/waves/test/icons/mind.svg',
      'desc': 'Test results that your analytical status describes you at best as:',
      'topSvg': 'assets/waves/test/Cogntop.svg',
    },
    {
      'title': 'Soft Skills Test',
      'result': 'Adaptive',
      'icon': 'assets/waves/test/icons/soft.svg',
      'desc': 'Test results that your social status describes you at best as:',
      'topSvg': 'assets/waves/test/softtop.svg',
    },
    {
      'title': 'Personality Test',
      'result': 'Curious',
      'icon': 'assets/waves/test/icons/personal.svg',
      'desc': 'Test results that your behavioral status describes you at best as:',
      'topSvg': 'assets/waves/test/personaltop.svg',
    },
    {
      'title': 'Learning Style Test',
      'result': 'Adaptive',
      'icon': 'assets/waves/test/icons/learn.svg',
      'desc': 'Test results that your learning preference describes you at best as:',
      'topSvg': 'assets/waves/test/learntop.svg',
    },
    {
      'title': 'Career Path Test',
      'result': 'Strategic',
      'icon': 'assets/waves/test/icons/career.svg',
      'desc': 'Test results that your professional path describes you at best as:',
      'topSvg': 'assets/waves/test/carerrtop.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final currentResult = results[testIndex];
    final bool isLastTest = testIndex == results.length - 1;

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Stack(
        children: [
          // 1. Background Layer
          Positioned.fill(
            child: Image.asset(
              'assets/SpaceBackground.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Base Top SVG (Constant Background Shape)
          Positioned(
            top: size.height*0.29,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/test/teststartop.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),

          // 3. Colored Top SVG from Figma (Radial Gradients)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              currentResult['topSvg']!,
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),

          // 4. Bottom SVG Layer (Using minibot.svg)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/test/minibot.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // 5. Content Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  SvgPicture.asset(
                    currentResult['icon']!,
                    width: 80,
                    height: 80,
                    colorFilter: const ColorFilter.mode(
                        Colors.white, BlendMode.srcIn),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${currentResult['title']} Complete!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    currentResult['desc']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentResult['result']!,
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          color: ColorManager.primary.withOpacity(0.8),
                          blurRadius: 25,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: index <= testIndex
                              ? ColorManager.primary
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLastTest) {
                          Navigator.of(context).popUntil((route) =>
                          route.isFirst);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TestDescription(testIndex: testIndex + 1),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorManager.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLastTest ? 'Finish All Tests' : 'Next test',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
