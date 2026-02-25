import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/features/assessment/presentation/screens/assessment_map_screen.dart';

class IntroStepsScreen extends StatefulWidget {
  const IntroStepsScreen({super.key});

  @override
  State<IntroStepsScreen> createState() => _IntroStepsScreenState();
}

class _IntroStepsScreenState extends State<IntroStepsScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<IntroStepData> _steps = [
    IntroStepData(
      title: 'Assessment Tests',
      description: 'To get started, you\'re gonna have to get through 5 essential cumulative tests for evaluating your character AND deciding the best CS track applicable for you',
      iconPath: 'assets/star/starttest.svg',
      topWave: 'assets/waves/welcoming_waves/top2.svg',
      bottomWave: 'assets/waves/welcoming_waves/bottom2.svg',
      isSvg: true,
    ),
    IntroStepData(
      title: 'Explore your\nhidden prospects',
      description: 'Follow a structured path that helps you learn, grow, and progress in the technical field—guided by the track that best aligns with your natural strengths',
      iconPath: 'assets/star/startgroup.svg',
      topWave: 'assets/waves/welcoming_waves/top3.svg',
      bottomWave: 'assets/waves/welcoming_waves/bottom3.svg',
      isSvg: true,
    ),
    IntroStepData(
      title: 'Gamified Learning',
      description: 'Studying was never more fun without adding some challenging environment. Beat levels, Promote your rank, Unlock Perks and much more!',
      iconPath: 'assets/star/rankgroup.png',
      topWave: 'assets/waves/welcoming_waves/top4.svg',
      bottomWave: 'assets/waves/welcoming_waves/bottom4.svg',
      isSvg: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      child: PageView.builder(
        controller: _pageController,
        itemCount: _steps.length,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        itemBuilder: (context, index) {
          return _buildPage(_steps[index]);
        },
      ),
    );
  }

  Widget _buildPage(IntroStepData data) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(data.topWave, fit: BoxFit.fitWidth),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(data.bottomWave, fit: BoxFit.fitWidth),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                data.isSvg 
                  ? SvgPicture.asset(data.iconPath, height: 220)
                  : Image.asset(data.iconPath, height: 220),
                
                const SizedBox(height: 40),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: ColorManager.textPrimary, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) => _buildStepIndicator(index)),
                ),
                const SizedBox(height: 32),
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: ColorManager.textSecondary, fontSize: 16, height: 1.5),
                ),
                const Spacer(),
                if (_currentIndex > 0) ...[
                  CustomButton(
                    text: 'Back',
                    isOutlined: true,
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300), 
                        curve: Curves.easeInOut
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
                CustomButton(
                  text: _currentIndex == 2 ? 'Get Started' : 'Next',
                  onPressed: () {
                    if (_currentIndex < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300), 
                        curve: Curves.easeInOut
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const AssessmentMapScreen()),
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
    );
  }

  Widget _buildStepIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 4,
      width: 24,
      decoration: BoxDecoration(
        color: _currentIndex == index ? ColorManager.primary : Colors.white24,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class IntroStepData {
  final String title;
  final String description;
  final String iconPath;
  final String topWave;
  final String bottomWave;
  final bool isSvg;

  IntroStepData({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.topWave,
    required this.bottomWave,
    required this.isSvg,
  });
}
