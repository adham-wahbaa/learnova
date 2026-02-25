import 'package:flutter/material.dart';

class TestCategoryModel {
  final String title;
  final String description;
  final String resultTitle;
  final String resultDesc;
  final String icon;
  final String topSvg;
  final String bgImage;

  const TestCategoryModel({
    required this.title,
    required this.description,
    required this.resultTitle,
    required this.resultDesc,
    required this.icon,
    required this.topSvg,
    required this.bgImage,
  });

  static const List<TestCategoryModel> tests = [
    TestCategoryModel(
      title: 'Cognitive Test',
      description: 'These tests are supervised by a group of expert researchers and are commonly classified as closed-source ones',
      resultTitle: 'Astute',
      resultDesc: 'Test results that your analytical status describes you at best as:',
      icon: 'assets/waves/test/icons/mind.svg',
      topSvg: 'assets/waves/test/Cogntop.svg',
      bgImage: 'assets/waves/test/cogntestbg.png',
    ),
    TestCategoryModel(
      title: 'Soft Skills Test',
      description: 'Evaluate your interpersonal skills and how you interact with others in a professional environment.',
      resultTitle: 'Analytical',
      resultDesc: 'Test results that your social status describes you at best as:',
      icon: 'assets/waves/test/icons/soft.svg',
      topSvg: 'assets/waves/test/softtop.svg',
      bgImage: 'assets/waves/test/softestbg.png',
    ),
    TestCategoryModel(
      title: 'Personality Test',
      description: 'Understand your personality traits and how they influence your work and learning habits.',
      resultTitle: 'Curious',
      resultDesc: 'Test results that your behavioral status describes you at best as:',
      icon: 'assets/waves/test/icons/personal.svg',
      topSvg: 'assets/waves/test/personaltop.svg',
      bgImage: 'assets/waves/test/persontestbg.png',
    ),
    TestCategoryModel(
      title: 'Learning Style Test',
      description: 'Discover the most effective ways for you to absorb, process, and retain new information.',
      resultTitle: 'Adaptive',
      resultDesc: 'Test results that your learning preference describes you at best as:',
      icon: 'assets/waves/test/icons/learn.svg',
      topSvg: 'assets/waves/test/learntop.svg',
      bgImage: 'assets/waves/test/learntestbg.png',
    ),
    TestCategoryModel(
      title: 'Career Path Test',
      description: 'Identify the tech roles and career paths that best align with your natural strengths and interests.',
      resultTitle: 'Data-Driven',
      resultDesc: 'Test results that your professional path describes you at best as:',
      icon: 'assets/waves/test/icons/career.svg',
      topSvg: 'assets/waves/test/carerrtop.svg',
      bgImage: 'assets/waves/test/carrertestbg.png',
    ),
  ];
}
