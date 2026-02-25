import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';
import 'package:learnova/view/login/test/test_complete.dart';

class QuestionsScreen extends StatefulWidget {
  final int testIndex;
  const QuestionsScreen({super.key, required this.testIndex});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  final int _totalQuestions = 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double progress = (_currentQuestionIndex + 1) / _totalQuestions;

    return Scaffold(
      backgroundColor: ColorManager.background,
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Progress Header
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        SvgPicture.asset(
                          'assets/star/star.svg', // Assuming this is the star icon from the image
                          width: 60,
                          height: 60,
                        ),
                        Text(
                          '${((_currentQuestionIndex + 1) / _totalQuestions * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Linear Progress Bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF72F7D7)),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Question Number
                  Text(
                    'Q.${_currentQuestionIndex + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Question Text
                  const Text(
                    'Just go ahead and select some answer from the ones below:',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      height: 1.5,
                    ),
                  ),
                  const Spacer(),
                  // Answer Options
                  Column(
                    children: List.generate(4, (index) {
                      bool isSelected = _selectedAnswerIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAnswerIndex = index;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                            decoration: BoxDecoration(
                              color: isSelected ? ColorManager.primary : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Answer ${index + 1}',
                              style: TextStyle(
                                color: isSelected ? Colors.black87 : Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  // Next Question Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _selectedAnswerIndex != null
                          ? () {
                              if (_currentQuestionIndex < _totalQuestions - 1) {
                                setState(() {
                                  _currentQuestionIndex++;
                                  _selectedAnswerIndex = null;
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TestCompleteScreen(testIndex: widget.testIndex),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: ColorManager.secondary,
                        disabledBackgroundColor: Colors.white24,
                        disabledForegroundColor: Colors.white38,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentQuestionIndex < _totalQuestions - 1 ? 'Next Question' : 'Finish Test',
                        style: const TextStyle(
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
}
