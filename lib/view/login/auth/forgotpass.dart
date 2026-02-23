import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/conest/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<bool> _hasText = List.generate(6, (_) => false);

  @override
  void initState() {
    super.initState();
    // إعداد مراقب للوحة المفاتيح لكل مربع لإكتشاف مسح النص (Backspace) حتى لو المربع فارغ
    for (int i = 0; i < 6; i++) {
      _focusNodes[i].onKeyEvent = (node, event) {
        if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
          // إذا كان المربع الحالي فارغاً والضغط على Backspace، ننتقل للمربع السابق ونمسحه
          if (_controllers[i].text.isEmpty && i > 0) {
            _controllers[i - 1].clear();
            _focusNodes[i - 1].requestFocus();
            setState(() {
              _hasText[i - 1] = false;
            });
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      };
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorManager.background,
      body: Stack(
        children: [
          // Background Layers
          Positioned.fill(
            child: Image.asset('assets/SpaceBackground.png', fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/top2.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/waves/bottom2.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 16),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                'Reset',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Password',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        RichText(
                          textAlign: TextAlign.start,
                          text: const TextSpan(
                            style: TextStyle(color: Colors.white70, fontSize: 16, height: 1.5),
                            children: [
                              TextSpan(text: 'A reset password email has been sent to '),
                              TextSpan(
                                text: 'mohannad19Ahmed@gmail.com.',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '\nConsider typing down the 6-digit code to proceed with the process.'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),

                        // 6-Digit Code Input
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) => _buildCodeBox(index)),
                        ),

                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Resend Code',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),
                        
                        // Reset Password Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: ColorManager.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Reset Password',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBox(int index) {
    return Container(
      width: 45,
      height: 60,
      decoration: BoxDecoration(
        color: _hasText[index] ? ColorManager.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _hasText[index] ? ColorManager.primary : Colors.white38,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(
          color: _hasText[index] ? ColorManager.secondary : Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _hasText[index] = value.isNotEmpty;
          });
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
        },
      ),
    );
  }
}
