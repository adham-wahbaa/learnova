import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/Welcoming%20Screen/steps_screen.dart';

class Welcoming extends StatelessWidget {
  const Welcoming({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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

          // 2. Top SVG Layer
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/welcoming_waves/top1.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),

          // 3. Bottom SVG Layer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/welcoming_waves/bottom1.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // 4. Content Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  // Star Icon
                  SvgPicture.asset(
                    'assets/star/star.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 40),
                  // Welcome Title
                  const Text(
                    'Welcome to',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Learnova!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Description Text
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Our platform is designed to understand how you ',
                        ),
                        TextSpan(
                          text: 'think, learn,',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'grow; ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'guiding you toward the computer science path that aligns with your strengths and ambitions!',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Our main goal is ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              'to give you a mentorship experience that adapts to you — your pace, your style, and your future goals in tech.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Let's shape the path that fits you best!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                       Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const OnboardingSteps()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorManager.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
