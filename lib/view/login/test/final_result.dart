import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/test_model.dart';

class FinalResultScreen extends StatelessWidget {
  const FinalResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Stack(
        children: [

          // 2. Background Bubbles (PNGs)
          Positioned(
            top: -50,
            left: -50,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset('assets/waves/test/circleup.png', width: 300),
            ),
          ),
          Positioned(
            bottom: 10,
            right: -80,
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                  'assets/waves/test/circlebown.png', width: 350),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 10,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                  'assets/waves/test/smallcircle.png', width: 120),
            ),
          ),

          // 3. Content Layer
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    // مساحة للجزء العلوي من الـ Avatar

                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        // الكونتينر الأبيض
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                          child: const Column(
                            children: [
                              SizedBox(height: 152),
                              // مساحة لترك مكان للجزء السفلي من الـ Avatar
                              Text(
                                'Tests Results:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 24),
                            ],
                          ),
                        ),

                        // الـ Avatar (نصفه بالخارج)
                        Positioned(
                          top: -136, // نصف قطر الدائرة (200/2)
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 272,
                                height: 272,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFD9E9F2).withValues(
                                      alpha: 0.7),
                                ),
                              ),
                              ClipOval(
                                child: SvgPicture.asset(
                                  'assets/avatar/avatar1.svg',
                                  width: 226,
                                  height: 226,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // قائمة النتائج
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: TestCategoryModel.tests.map((test) =>
                            _buildResultRow(test)).toList(),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(TestCategoryModel test) {
    return Container(
      width: double.infinity,
      height: 72,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(test.bgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            SvgPicture.asset(
              test.icon,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                  Colors.white, BlendMode.srcIn),
            ),
            const SizedBox(width: 16),
            Text(
              test.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              test.resultTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}