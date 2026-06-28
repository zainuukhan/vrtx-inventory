import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_text_styles.dart';

class RevenueCard extends StatelessWidget {
  final double revenue;
  final double profit;

  const RevenueCard({super.key, required this.revenue, required this.profit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXL),
        gradient: const LinearGradient(
          colors: [Color(0xffE50914), Color(0xff9B0000)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Revenue",
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),

          const SizedBox(height: 12),

          Text(
            "Rs ${revenue.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              const Icon(Icons.trending_up, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                "Profit Rs ${profit.toStringAsFixed(0)}",
                style: AppTextStyles.body,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
