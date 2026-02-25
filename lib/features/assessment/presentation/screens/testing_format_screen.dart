import 'package:flutter/material.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/features/assessment/presentation/screens/test_description_screen.dart';
// import 'test_description_screen.dart'; // سأقوم بإنشائه بعد قليل

class TestingFormatScreen extends StatefulWidget {
  const TestingFormatScreen({super.key});

  @override
  State<TestingFormatScreen> createState() => _TestingFormatScreenState();
}

class _TestingFormatScreenState extends State<TestingFormatScreen> {
  int? _selectedFormat; // 0 for Within App, 1 for On Browser

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      topWavePaths: ['assets/waves/test/teststartop.svg'],
      bottomWavePaths: ['assets/waves/test/teststartbot.svg'],
      child: SafeArea(
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
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Your progress in the tests is actively saved, so ',
                    ),
                    TextSpan(
                      text: 'abrupt exiting and resuming',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    TextSpan(
                      text: ' won\'t be much trouble',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Next Button
              CustomButton(
                text: 'Next',
                onPressed: _selectedFormat != null ? () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => const TestDescriptionScreen(testIndex: 0)));
                } : null,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
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
              color: Colors.black87,
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
