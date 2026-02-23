import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/testmap.dart';

class OnboardingSteps extends StatefulWidget {
  const OnboardingSteps({super.key});

  @override
  State<OnboardingSteps> createState() => _OnboardingStepsState();
}

class _OnboardingStepsState extends State<OnboardingSteps> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isNextButtonTapped = false;
  bool _isBackButtonTapped = false;

  final List<OnboardingData> _steps = [
    OnboardingData(
      title: 'Assessment Tests',
      description: 'To get started, you\'re gonna have to get through 5 essential cumulative tests for evaluating your character AND deciding the best CS track applicable for you',
      iconPath: 'assets/star/starttest.svg',
      topWave: 'assets/waves/welcoming_waves/top2.svg',
      bottomWave: 'assets/waves/welcoming_waves/bottom2.svg',
      isSvg: true,
    ),
    OnboardingData(
      title: 'Explore your\nhidden prospects',
      description: 'Follow a structured path that helps you learn, grow, and progress in the technical field—guided by the track that best aligns with your natural strengths',
      iconPath: 'assets/star/startgroup.svg',
      topWave: 'assets/waves/welcoming_waves/top3.svg',
      bottomWave: 'assets/waves/welcoming_waves/bottom3.svg',
      isSvg: true,
    ),
    OnboardingData(
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
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/SpaceBackground.png', fit: BoxFit.cover),
          ),

          PageView.builder(
            controller: _pageController,
            itemCount: _steps.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (context, index) {
              return _buildPage(context, _steps[index], size);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, OnboardingData data, Size size) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(data.topWave, width: size.width, fit: BoxFit.fitWidth),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(data.bottomWave, width: size.width, fit: BoxFit.fitWidth),
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
                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
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
                  style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
                ),
                const Spacer(),
                if (_currentIndex > 0) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () async {
                        setState(() => _isBackButtonTapped = true);
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300), 
                          curve: Curves.easeInOut
                        );
                        await Future.delayed(const Duration(milliseconds: 100));
                        if (mounted) {
                          setState(() => _isBackButtonTapped = false);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (_isBackButtonTapped || states.contains(WidgetState.pressed)) {
                            return ColorManager.primary;
                          }
                          return Colors.transparent;
                        }),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
                          if (_isBackButtonTapped || states.contains(WidgetState.pressed)) {
                            return const BorderSide(color: ColorManager.primary);
                          }
                          return const BorderSide(color: Colors.white70);
                        }),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      child: const Text('Back', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() => _isNextButtonTapped = true);
                      
                      if (_currentIndex < 2) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300), 
                          curve: Curves.easeInOut
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const TestMap()),
                        );
                      }
                      
                      await Future.delayed(const Duration(milliseconds: 100));
                      if (mounted) {
                        setState(() => _isNextButtonTapped = false);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                        if (_isNextButtonTapped || states.contains(WidgetState.pressed)) {
                          return ColorManager.primary;
                        }
                        return Colors.white;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                        if (_isNextButtonTapped || states.contains(WidgetState.pressed)) {
                          return Colors.white;
                        }
                        return ColorManager.secondary;
                      }),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    child: Text(
                      _currentIndex == 2 ? 'Get Started' : 'Next',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
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

class OnboardingData {
  final String title;
  final String description;
  final String iconPath;
  final String topWave;
  final String bottomWave;
  final bool isSvg;

  OnboardingData({
    required this.title,
    required this.description,
    required this.iconPath,
    required this.topWave,
    required this.bottomWave,
    required this.isSvg,
  });
}
