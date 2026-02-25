import 'package:flutter/material.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/features/auth/presentation/screens/signup_screen.dart';
import 'package:learnova/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:learnova/features/auth/presentation/screens/avatar_selection_screen.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SpaceScaffold(
      topWavePaths: const [
        'assets/waves/top2.svg',
        'assets/waves/primeTop2.svg',
      ],
      bottomWavePaths: const [
        'assets/waves/bottom2.svg',
        'assets/waves/primebottom2.svg',
      ],
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 48),

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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const AvatarSelectionScreen()),
                    );
                  },
                ),

                const SizedBox(height: 64),

                // Custom OR Divider
                Row(
                  children: [
                    _buildDot(),
                    const Expanded(
                      child: Divider(
                        color: Colors.white38,
                        thickness: 1,
                        indent: 0,
                        endIndent: 16,
                      ),
                    ),
                    const Text(
                      'or',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.white38,
                        thickness: 1,
                        indent: 16,
                        endIndent: 0,
                      ),
                    ),
                    _buildDot(),
                  ],
                ),

                const SizedBox(height: 64),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: SignInButton(
                    Buttons.google,
                    text: "Sign up with Google",
                    onPressed: () {},
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: SignInButton(
                    Buttons.facebookNew,
                    text: "Sign up with Facebook",
                    onPressed: () {},
                  ),
                ),

                const SizedBox(height: 48),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New Member? ',
                      style: TextStyle(color: ColorManager.textSecondary),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text(
                        'Sign up',
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
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
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
