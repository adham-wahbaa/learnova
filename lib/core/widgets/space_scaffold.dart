import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';

class SpaceScaffold extends StatelessWidget {
  final Widget child;
  final String? topWavePath;
  final String? bottomWavePath;
  final Color? topWaveColor;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;

  const SpaceScaffold({
    super.key,
    required this.child,
    this.topWavePath,
    this.bottomWavePath,
    this.topWaveColor,
    this.extendBodyBehindAppBar = false,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.background,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      body: Stack(
        children: [
          // 1. Background Layer
          Positioned.fill(
            child: Image.asset(
              'assets/SpaceBackground.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Top Wave Layer
          if (topWavePath != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: topWaveColor != null
                  ? SvgPicture.asset(
                      topWavePath!,
                      width: size.width,
                      fit: BoxFit.fitWidth,
                      colorFilter: ColorFilter.mode(topWaveColor!, BlendMode.srcIn),
                    )
                  : SvgPicture.asset(
                      topWavePath!,
                      width: size.width,
                      fit: BoxFit.fitWidth,
                    ),
            ),

          // 3. Bottom Wave Layer
          if (bottomWavePath != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                bottomWavePath!,
                width: size.width,
                fit: BoxFit.fitWidth,
              ),
            ),

          // 4. Content Layer
          child,
        ],
      ),
    );
  }
}
