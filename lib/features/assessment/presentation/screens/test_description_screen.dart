import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/features/assessment/domain/models/assessment_test_model.dart';
import 'package:learnova/features/assessment/presentation/screens/test_questions_screen.dart';

class TestDescriptionScreen extends StatelessWidget {
  final int testIndex;

  const TestDescriptionScreen({super.key, required this.testIndex});

  @override
  Widget build(BuildContext context) {
    final currentTest = AssessmentTestModel.tests[testIndex];
    final nextTest = AssessmentTestModel.tests[(testIndex + 1) % AssessmentTestModel.tests.length];
    final isLastTest = testIndex == AssessmentTestModel.tests.length - 1;

    return SpaceScaffold(
      topWavePath: 'assets/waves/test/teststartop.svg',
      bottomWavePath: 'assets/waves/test/teststartbot.svg',
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Test Description',
          style: TextStyle(color: Colors.white70, fontSize: 18),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SvgPicture.asset(
                currentTest.icon,
                width: 80,
                height: 80,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(height: 20),
              Text(
                currentTest.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                currentTest.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Test Status:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.description_outlined, color: Colors.white70, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "15 MCQ Questions",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
              const Spacer(),
              if (!isLastTest) ...[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [ColorManager.primary, Color(0xFF3DA9A5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Up next:',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              nextTest.icon,
                              width: 30,
                              height: 30,
                              colorFilter: const ColorFilter.mode(Colors.black87, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              nextTest.title,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
              CustomButton(
                text: 'Take test',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestQuestionsScreen(testIndex: testIndex),
                    ),
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
