import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_text_styles.dart';
import 'app_card.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: (color ?? AppColors.primary).withOpacity(.15),
            child: Icon(icon, color: color ?? AppColors.primary),
          ),

          const SizedBox(height: 18),

          Text(title, style: AppTextStyles.statTitle),

          const SizedBox(height: 6),

          Text(value, style: AppTextStyles.statValue),
        ],
      ),
    );
  }
}
