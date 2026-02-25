import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/features/assessment/domain/models/assessment_test_model.dart';
import 'package:learnova/features/assessment/presentation/screens/test_description_screen.dart';
import 'package:learnova/features/assessment/presentation/screens/final_results_summary_screen.dart';

class TestCompleteScreen extends StatelessWidget {
  final int testIndex;

  const TestCompleteScreen({super.key, required this.testIndex});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final currentResult = AssessmentTestModel.tests[testIndex];
    final bool isLastTest = testIndex == AssessmentTestModel.tests.length - 1;

    return SpaceScaffold(
      child: Stack(
        children: [
          // Base Top SVG (Constant Background Shape)
          Positioned(
            top: size.height * 0.29,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/test/teststartop.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              currentResult.topSvg,
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),

          // Bottom SVG Layer (Using minibot.svg)
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

          // Content Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  SvgPicture.asset(
                    currentResult.icon,
                    width: 80,
                    height: 80,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${currentResult.title} Complete!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Text(
                    currentResult.resultDesc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorManager.textSecondary,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentResult.resultTitle,
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      shadows: [
                        Shadow(
                          color: ColorManager.primary.withValues(alpha: 0.8),
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
                  CustomButton(
                    text: isLastTest ? 'Finish All Tests' : 'Next test',
                    onPressed: () {
                      if (isLastTest) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FinalResultsSummaryScreen(),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TestDescriptionScreen(testIndex: testIndex + 1),
                          ),
                        );
                      }
                    },
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
