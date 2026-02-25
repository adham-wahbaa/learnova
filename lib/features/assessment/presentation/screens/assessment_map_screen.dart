import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/features/assessment/domain/models/assessment_test_model.dart';
import 'package:learnova/features/assessment/presentation/screens/testing_format_screen.dart';

class AssessmentMapScreen extends StatefulWidget {
  const AssessmentMapScreen({super.key});

  @override
  State<AssessmentMapScreen> createState() => _AssessmentMapScreenState();
}

class _AssessmentMapScreenState extends State<AssessmentMapScreen> {
  late PageController _pageController;
  static const int _initialPage = 1000;
  int _currentPageIndex = 2;
  late int _currentActivePage;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentActivePage = _initialPage + 2;
    _pageController = PageController(
      viewportFraction: 0.55,
      initialPage: _currentActivePage,
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_pageController.hasClients) {
        _currentActivePage++;
        _pageController.animateToPage(
          _currentActivePage,
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      topWavePaths: ['assets/waves/test/teststartop.svg'],
      bottomWavePaths: ['assets/waves/test/teststartbot.svg'],
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 64),
            const Text(
              'Tests Map',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 2),
            SizedBox(
              height: 320,
              child: AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  return PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        _currentActivePage = value;
                        _currentPageIndex = value % AssessmentTestModel.tests.length;
                      });
                    },
                    itemBuilder: (context, index) {
                      final categoryIndex = index % AssessmentTestModel.tests.length;
                      final test = AssessmentTestModel.tests[categoryIndex];

                      double relativePosition = 0;
                      if (_pageController.position.haveDimensions) {
                        relativePosition = index - _pageController.page!;
                      } else {
                        relativePosition = (index - _currentActivePage).toDouble();
                      }

                      double absPos = relativePosition.abs();
                      double yOffset = math.pow(absPos, 2) * 35;
                      double scale = (1 - (absPos * 0.3)).clamp(0.5, 1.1);
                      double opacity = (1 - (absPos * 0.4)).clamp(0.3, 1.0);

                      return Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..translate(0.0, yOffset, 0.0)
                          ..scale(scale),
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: opacity,
                          child: Center(
                            child: _buildCategoryCard(test, absPos < 0.5),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: RichText(
                  key: ValueKey<int>(_currentPageIndex),
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                    children: _buildDescriptionSpans(
                        AssessmentTestModel.tests[_currentPageIndex].description),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: CustomButton(
                text: 'Next',
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const TestingFormatScreen())
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(AssessmentTestModel test, bool isActive) {
    // Note: The original colors were in TestMap, but now we use Model. 
    // For simplicity in the card, we'll use a fixed gradient or primary color if model doesn't have list of colors.
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: isActive
            ? const LinearGradient(
                colors: [Color(0xFF72F7D7), Color(0xFF03478E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isActive ? null : Colors.white.withOpacity(0.1),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFF72F7D7).withOpacity(0.4),
                  blurRadius: 25,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            test.icon,
            width: 60,
            height: 60,
            colorFilter: ColorFilter.mode(
              isActive ? Colors.black87 : Colors.white60,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              test.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? Colors.black87 : Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildDescriptionSpans(String text) {
    final parts = text.split('expert researchers');
    if (parts.length > 1) {
      return [
        TextSpan(text: parts[0]),
        const TextSpan(
          text: 'expert researchers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF72F7D7),
          ),
        ),
        TextSpan(text: parts[1]),
      ];
    }
    return [TextSpan(text: text)];
  }
}
