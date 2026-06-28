import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const heading = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    letterSpacing: -.5,
  );

  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const subtitle = TextStyle(fontSize: 16, color: AppColors.grey);

  static const body = TextStyle(fontSize: 15, color: AppColors.white);

  static const caption = TextStyle(fontSize: 13, color: AppColors.grey);

  static const statValue = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const statTitle = TextStyle(fontSize: 14, color: AppColors.grey);

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
