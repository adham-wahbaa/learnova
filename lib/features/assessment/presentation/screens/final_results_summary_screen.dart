import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/features/assessment/domain/models/assessment_test_model.dart';

class FinalResultsSummaryScreen extends StatelessWidget {
  const FinalResultsSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      child: Stack(
        children: [
          // Background Bubbles (PNGs)
          Positioned(
            top: -50,
            right: -50,
            child: Opacity(
              opacity: 0.6,
              child: Image.asset('assets/waves/test/circleup.png', width: 300),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -80,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset('assets/waves/test/circlebown.png', width: 350),
            ),
          ),
          Positioned(
            top: 250,
            left: 10,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset('assets/waves/test/smallcircle.png', width: 120),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        // White Container
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
                              SizedBox(height: 110),
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
                        
                        // Avatar
                        Positioned(
                          top: -100,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFD9E9F2).withValues(alpha: 0.7),
                                ),
                              ),
                              ClipOval(
                                child: SvgPicture.asset(
                                  'assets/avatar/avatar1.svg',
                                  width: 170,
                                  height: 170,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Results List
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        children: AssessmentTestModel.tests.map((test) => _buildResultRow(test)).toList(),
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

  Widget _buildResultRow(AssessmentTestModel test) {
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
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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
