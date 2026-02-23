import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Avatar extends StatefulWidget {
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
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

  int? _selectedAvatarIndex; // لتخزين الأفاتار المختار حالياً

  @override
  void initState() {
    super.initState();
    // اختيار أول أفاتار كافتراضي
    _selectedAvatarIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF041C32),
      body: Stack(
        children: [
          // 1. الخلفيات الثابتة
          Positioned.fill(
            child: Image.asset('assets/SpaceBackground.png', fit: BoxFit.cover),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/top.svg',
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
              'assets/bottomhigh.svg',
              width: size.width,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // 2. المحتوى الرئيسي للصفحة
          SafeArea(
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
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                
                const SizedBox(height: 24),


                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: const Color(0xFFB8D5E5).withOpacity(0.8),
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
                        border: Border.all(color: const Color(0xFF041C32), width: 2)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.camera_alt, color: Color(0xFF041C32), size: 24),
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
                                  ? Border.all(color: const Color(0xFF72F7D7), width: 3)
                                  : null,
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xFFB8D5E5).withOpacity(0.8),
                              child: SvgPicture.asset('assets/avatar/${avatars[index]}'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // -- زر الحفظ --
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action to save avatar choice
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF041C32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save & Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 64,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
