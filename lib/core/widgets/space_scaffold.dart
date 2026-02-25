import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnova/core/theme/app_colors.dart';

class SpaceScaffold extends StatelessWidget {
  final Widget child;
  final List<String>? topWavePaths;
  final List<String>? bottomWavePaths;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final bool resizeToAvoidBottomInset;

  const SpaceScaffold({
    super.key,
    required this.child,
    this.topWavePaths,
    this.bottomWavePaths,
    this.extendBodyBehindAppBar = false,
    this.appBar,
    this.resizeToAvoidBottomInset = false,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorManager.background,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
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

          // 2. Top Wave Layers
          if (topWavePaths != null)
            ...topWavePaths!.map(
              (path) => Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  path,
                  width: size.width,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),

          // 3. Bottom Wave Layers
          if (bottomWavePaths != null)
            ...bottomWavePaths!.map(
              (path) => Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  path,
                  width: size.width,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),

          // 4. Content Layer
          child,
        ],
      ),
    );
  }
}
