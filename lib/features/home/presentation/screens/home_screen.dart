import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    final double topPadding = MediaQuery
        .of(context)
        .padding
        .top;

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: Stack(
        children: [
          // 1. Background Layer (Fixed)
          Positioned.fill(
            child: Image.asset(
              'assets/SpaceBackground.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Scrollable Content
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: topPadding + 80),

                  // Scrollable Top Wave
                  SvgPicture.asset(
                    'assets/map/scrolltop.svg',
                    width: size.width,
                    fit: BoxFit.fitWidth,
                  ),

                  const SizedBox(height: 10),

                  _buildLevelHeader('Level 1'),

                  const SizedBox(height: 40),

                  // Map Content
                  _buildMapContent(size),

                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),

          // 3. Fixed Top Decorative Wave
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: SvgPicture.asset(
                'assets/map/fixedtop.svg',
                width: size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          // 4. Fixed Top Bar (Stats)
          Positioned(
            top: topPadding,
            left: 0,
            right: 0,
            child: _buildTopBar(),
          ),

          // 5. Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapContent(Size size) {
    // حسابات إحداثيات منتصف المستويات ليرسم المسار بينهم بدقة
    // Level 1: Island width 0.9, levelTop: 28, levelRight: 118. Icon width is 65.
    double x1 = (size.width + size.width * 0.9) / 2 - 118 - 40;
    double y1 = 28 + 32.5 + 30;

    // Level 2: Offset left 70, Island width 0.6, levelTop: -10, levelRight: 110
    double x2 = 70 + (size.width * 0.6) - 110 - 32.5;
    // ارتفاع تقديري للجزيرة الأولى بناءً على العرض + المسافة الفاصلة
    double y2 = (size.width * 0.45) + 30 ;

    return SizedBox(
      width: size.width,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          // Dashed Path (CustomPaint)


          // Islands
          Column(
            children: [
              _buildIslandItem(
                islandImage: 'assets/map/island1.png',
                levelImage: 'assets/map/lev1.png',
                levelNumber: '1',
                width: size.width * 0.90,
                levelTop: 28,
                levelRight: 118,
              ),
              const SizedBox(height: 52),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: _buildIslandItem(
                    islandImage: 'assets/map/island2.png',
                    levelImage: 'assets/map/lev2.png',
                    levelNumber: '2',
                    width: size.width * 0.60,
                    levelTop: -10,
                    levelRight: 110,
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: DashedPathPainter(
                start: Offset(x1, y1),
                end: Offset(x2, y2),
                control: Offset(size.width * 0.3, (y1 + y2) / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/star/star.svg', width: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Novice',
                    style: TextStyle(color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                width: 100,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'Levels',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 80),
        ],
      ),
    );
  }

  Widget _buildLevelHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 32),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 32),
      ],
    );
  }

  Widget _buildIslandItem({
    required String islandImage,
    required String levelImage,
    required String levelNumber,
    required double width,
    double? levelTop,
    double? levelBottom,
    double? levelLeft,
    double? levelRight,
  }) {
    return SizedBox(
      width: width,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            islandImage,
            width: width,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, color: Colors.white24, size: 50),
          ),
          Positioned(
            top: levelTop,
            bottom: levelBottom,
            left: levelLeft,
            right: levelRight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(levelImage, width: 65),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    levelNumber,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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

  Widget _buildBottomNav() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: const Color(0xFF03478E).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white10),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home_outlined, color: ColorManager.primary, size: 32),
          Icon(Icons.map_outlined, color: Colors.white60, size: 30),
          Icon(Icons.notifications_none, color: Colors.white60, size: 30),
          Icon(Icons.leaderboard_outlined, color: Colors.white60, size: 30),
          Icon(Icons.person_outline, color: Colors.white60, size: 30),
        ],
      ),
    );
  }
}

class DashedPathPainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Offset control;

  DashedPathPainter({
    required this.start,
    required this.end,
    required this.control,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final glowPaint = Paint()
      ..color = ColorManager.primary.withValues(alpha: 0.2)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    final path = Path();
    path.moveTo(start.dx, start.dy);
    path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);

    for (PathMetric measurePath in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < measurePath.length) {
        final Path extractPath = measurePath.extractPath(
            distance, distance + 12);
        canvas.drawPath(extractPath, glowPaint);
        canvas.drawPath(extractPath, paint);
        distance += 24;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}