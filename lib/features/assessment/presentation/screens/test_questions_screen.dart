import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/features/assessment/presentation/screens/test_complete_screen.dart';

class TestQuestionsScreen extends StatefulWidget {
  final int testIndex;
  const TestQuestionsScreen({super.key, required this.testIndex});

  @override
  State<TestQuestionsScreen> createState() => _TestQuestionsScreenState();
}

class _TestQuestionsScreenState extends State<TestQuestionsScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  final int _totalQuestions = 15;

  @override
  Widget build(BuildContext context) {
    double progress = (_currentQuestionIndex + 1) / _totalQuestions;

    return SpaceScaffold(
      topWavePath: 'assets/waves/test/teststartop.svg',
      bottomWavePath: 'assets/waves/test/teststartbot.svg',
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/star/star.svg',
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(ColorManager.primary),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Q.${_currentQuestionIndex + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Just go ahead and select some answer from the ones below:',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  height: 1.5,
                ),
              ),
              const Spacer(),
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
                            color: isSelected ? ColorManager.secondary : Colors.black87,
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
              CustomButton(
                text: _currentQuestionIndex < _totalQuestions - 1 ? 'Next Question' : 'Finish Test',
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
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
