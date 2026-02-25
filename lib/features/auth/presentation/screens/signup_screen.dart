import 'package:flutter/material.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/features/auth/presentation/screens/login_screen.dart';
import 'package:learnova/features/auth/presentation/screens/avatar_selection_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SpaceScaffold(
      resizeToAvoidBottomInset: false,
      topWavePaths: const [
        'assets/waves/top.svg',
        'assets/waves/primeTop.svg',
      ],
      bottomWavePaths: const [
        'assets/waves/primebottom.svg',
        'assets/waves/bottom.svg',
      ],
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 32.0,
                      right: 32.0,
                      bottom: keyboardHeight + 32,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 80),
                        const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        _buildTextField(label: 'Username'),
                        const SizedBox(height: 24),
                        _buildTextField(label: 'Email'),
                        const SizedBox(height: 24),
                        _buildTextField(
                          label: 'Password',
                          isPassword: true,
                          obscureText: _obscurePassword,
                          onToggleVisibility: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildTextField(
                          label: 'Confirm Password',
                          isPassword: true,
                          obscureText: _obscureConfirmPassword,
                          onToggleVisibility: () => setState(
                            () => _obscureConfirmPassword = !_obscureConfirmPassword,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _agreeToTerms,
                              onChanged: (value) => setState(
                                () => _agreeToTerms = value ?? false,
                              ),
                              side: const BorderSide(color: Colors.white),
                              checkColor: ColorManager.secondary,
                              activeColor: Colors.white,
                            ),
                            const Expanded(
                              child: Text(
                                'I agree to the terms and conditions',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const Spacer(), // يرفع المحتوى العلوي للأعلى ويدفع السفلي للأسفل
                        
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have account? ',
                              style: TextStyle(color: ColorManager.textSecondary),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              ' here!',
                              style: TextStyle(color: ColorManager.textSecondary),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        CustomButton(
                          text: 'Save & Continue',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const AvatarSelectionScreen()),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: ColorManager.textSecondary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white38),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: ColorManager.textSecondary,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
      ),
    );
  }
}
