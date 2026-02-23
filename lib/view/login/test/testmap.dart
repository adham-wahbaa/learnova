import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/testing_format.dart';

class TestCategory {
  final String title;
  final String description;
  final String icon;
  final List<Color> colors;

  TestCategory({
    required this.title,
    required this.description,
    required this.icon,
    required this.colors,
  });
}

class TestMap extends StatefulWidget {
  const TestMap({super.key});

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  late PageController _pageController;

  // نستخدم قيمة كبيرة للبداية لتمكين التمرير اللانهائي في الاتجاهين
  static const int _initialPage = 1000;
  int _currentPageIndex = 2; // الفهرس الفعلي (0-4)
  late int _currentActivePage; // الصفحة الحالية في الـ PageView

  Timer? _timer;

  final List<TestCategory> categories = [
    TestCategory(
      title: 'Cognitive Test',
      description:
          'These tests are supervised by a group of expert researchers and are commonly classified as closed-source ones',
      icon: 'assets/waves/test/icons/mind.svg',
      colors: [const Color(0xFF72F7D7), const Color(0xFF03478E)],
    ),
    TestCategory(
      title: 'Soft Skills',
      description:
          'Evaluate your interpersonal skills and how you interact with others in a professional environment.',
      icon: 'assets/waves/test/icons/soft.svg',
      colors: [const Color(0xFF00BFE1), const Color(0xFF007E9B)],
    ),
    TestCategory(
      title: 'Learning Style',
      description:
          'Discover the most effective ways for you to absorb, process, and retain new information.',
      icon: 'assets/waves/test/icons/learn.svg',
      colors: [const Color(0xFF00DDE1), const Color(0xFF22269B)],
    ),
    TestCategory(
      title: 'Career Path',
      description:
          'Identify the tech roles and career paths that best align with your natural strengths and interests.',
      icon: 'assets/waves/test/icons/career.svg',
      colors: [const Color(0xFF4AC8FE), const Color(0xFF2FABE0)],
    ),
    TestCategory(
      title: 'Personality',
      description:
          'Understand your personality traits and how they influence your work and learning habits.',
      icon: 'assets/waves/test/icons/personal.svg',
      colors: [const Color(0xFF72F7D7), const Color(0xFF3EBEB1)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentActivePage = _initialPage + 2;
    // تم تعديل viewportFraction ليناسب العرض المطلوب (200) بالنسبة لعرض الشاشة
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
              'assets/waves/test/teststartop.svg',
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
              'assets/waves/test/teststartbot.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // 4. Content Layer
          SafeArea(
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

                // Orbital Infinite Carousel
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
                            _currentPageIndex = value % categories.length;
                          });
                        },
                        itemBuilder: (context, index) {
                          final categoryIndex = index % categories.length;

                          double relativePosition = 0;
                          if (_pageController.position.haveDimensions) {
                            relativePosition = index - _pageController.page!;
                          } else {
                            relativePosition =
                                (index - _currentActivePage).toDouble();
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
                                child: _buildCategoryCard(
                                  categories[categoryIndex],
                                  absPos < 0.5,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Description Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.2),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
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
                            categories[_currentPageIndex].description),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 3),

                // Next Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TestingFormat()));
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
                        'Next',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(TestCategory category, bool isActive) {
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: isActive
            ? LinearGradient(
                colors: category.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isActive ? null : Colors.white.withOpacity(0.1),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: category.colors[0].withOpacity(0.4),
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
            category.icon,
            width: 60, // تصغير الأيقونة لتناسب الحجم الجديد
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
              category.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isActive ? Colors.black87 : Colors.white70,
                fontSize: 14, // تصغير الخط قليلاً
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
