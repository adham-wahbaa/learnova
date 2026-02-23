import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/test_description.dart';

class TestingFormat extends StatefulWidget {
  const TestingFormat({super.key});

  @override
  State<TestingFormat> createState() => _TestingFormatState();
}

class _TestingFormatState extends State<TestingFormat> {
  int? _selectedFormat; // 0 for Within App, 1 for On Browser

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'Testing Format',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Select how are you taking the assessment tests:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  
                  // Format Options
                  _buildFormatCard(
                    index: 0,
                    title: 'Within App',
                    icon: Icons.smartphone_outlined,
                    isSelected: _selectedFormat == 0,
                  ),
                  const SizedBox(height: 24),
                  _buildFormatCard(
                    index: 1,
                    title: 'On Browser',
                    icon: Icons.language_outlined,
                    isSelected: _selectedFormat == 1,
                  ),

                  const Spacer(),
                  
                  // P.S Text
                  RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: 'P.S: ',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Your progress in the tests is actively saved, so ',
                        ),
                        TextSpan(
                          text: 'abrupt exiting and resuming',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        TextSpan(
                          text: ' won\'t be much trouble',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Next Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _selectedFormat != null ? () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TestDescription(testIndex: 0)));
                        // Navigate to next
                      } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorManager.secondary,
                        disabledBackgroundColor: Colors.white.withOpacity(0.3),
                        disabledForegroundColor: Colors.white60,
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
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatCard({
    required int index,
    required String title,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFormat = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 162,
        height: 178,
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorManager.primary.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  )
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: isSelected ? Colors.black87 : Colors.black87,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
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
