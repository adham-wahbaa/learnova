import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnova/core/theme/app_colors.dart';
import 'package:learnova/core/widgets/custom_button.dart';
import 'package:learnova/core/widgets/space_scaffold.dart';
import 'package:learnova/features/onboarding/presentation/screens/welcome_screen.dart';

class AvatarSelectionScreen extends StatefulWidget {
  const AvatarSelectionScreen({super.key});

  @override
  State<AvatarSelectionScreen> createState() => _AvatarSelectionScreenState();
}

class _AvatarSelectionScreenState extends State<AvatarSelectionScreen> {
  final List<String> avatars = [
    'avatar1.svg',
    'avatar2.svg',
    'avatar3.svg',
    'avatar4.svg',
    'avatar5.svg',
    'avatar6.svg',
    'avatar7.svg',
    'avatar8.svg',
  ];

  int? _selectedAvatarIndex;

  @override
  void initState() {
    super.initState();
    _selectedAvatarIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SpaceScaffold(
      topWavePaths: ['assets/top.svg'],
      bottomWavePaths: ['assets/bottomhigh.svg'],
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            const Text(
              'Set Avatar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Select your Prefab',
              style: TextStyle(color: ColorManager.textSecondary, fontSize: 16),
            ),
            
            const SizedBox(height: 24),

            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: const Color(0xFFB8D5E5).withValues(alpha: 0.8),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.transparent,
                    child: _selectedAvatarIndex != null
                        ? SvgPicture.asset('assets/avatar/${avatars[_selectedAvatarIndex!]}')
                        : null,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: ColorManager.secondary, width: 2)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.camera_alt, color: ColorManager.secondary, size: 24),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: avatars.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = _selectedAvatarIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatarIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: isSelected 
                              ? Border.all(color: ColorManager.primary, width: 3)
                              : null,
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xFFB8D5E5).withValues(alpha: 0.8),
                          child: SvgPicture.asset('assets/avatar/${avatars[index]}'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
              child: CustomButton(
                text: 'Save & Continue',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
