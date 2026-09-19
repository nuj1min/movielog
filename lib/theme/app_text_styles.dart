import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  static const headlineSmall = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.black,
  );
  static const titleLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );
  static const bodyMedium = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: AppColors.black,
  );
  static const bodySmall = TextStyle(
    fontSize: 14,
    height: 1.5,
    color: AppColors.gray,
  );
}
