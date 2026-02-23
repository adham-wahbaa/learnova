import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/questions_screen.dart';

class TestInfo {
  final String title;
  final String description;
  final String icon;
  final String questions;

  TestInfo({
    required this.title,
    required this.description,
    required this.icon,
    this.questions = "15 MCQ Questions",
  });
}

class TestDescription extends StatelessWidget {
  final int testIndex;

  const TestDescription({super.key, required this.testIndex});

  static final List<TestInfo> tests = [
    TestInfo(
      title: 'Cognitive Test',
      description: 'These tests are supervised by a group of expert researchers and are commonly classified as closed-source ones',
      icon: 'assets/waves/test/icons/mind.svg',
    ),
    TestInfo(
      title: 'Soft Skills Test',
      description: 'Evaluate your interpersonal skills and how you interact with others in a professional environment.',
      icon: 'assets/waves/test/icons/soft.svg',
    ),
    TestInfo(
      title: 'Personality Test',
      description: 'Understand your personality traits and how they influence your work and learning habits.',
      icon: 'assets/waves/test/icons/personal.svg',
    ),
    TestInfo(
      title: 'Learning Style Test',
      description: 'Discover the most effective ways for you to absorb, process, and retain new information.',
      icon: 'assets/waves/test/icons/learn.svg',
    ),
    TestInfo(
      title: 'Career Path Test',
      description: 'Identify the tech roles and career paths that best align with your natural strengths and interests.',
      icon: 'assets/waves/test/icons/career.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final currentTest = tests[testIndex];
    final nextTest = tests[(testIndex + 1) % tests.length];
    final isLastTest = testIndex == tests.length - 1;

    return Scaffold(
      backgroundColor: ColorManager.background,
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
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/SpaceBackground.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
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
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/test/teststartbot.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SafeArea(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.description_outlined, color: Colors.white70, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        currentTest.questions,
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
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
                          colors: [Color(0xFF72F7D7), Color(0xFF3DA9A5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
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
                    const SizedBox(height: 80),
                  ],
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuestionsScreen(testIndex: testIndex),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorManager.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Take test',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
