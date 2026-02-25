import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/features/onboarding/presentation/screens/intro_steps_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      topWavePaths: ['assets/waves/welcoming_waves/top1.svg'],
      bottomWavePaths: ['assets/waves/welcoming_waves/bottom1.svg'],
      child: SafeArea(
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
              CustomButton(
                text: 'Next',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const IntroStepsScreen()),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
