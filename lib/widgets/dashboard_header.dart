import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_text_styles.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  String greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.storefront, color: Colors.white),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting(), style: AppTextStyles.subtitle),
              const SizedBox(height: 4),
              const Text("VRTX WEAR", style: AppTextStyles.heading),
            ],
          ),
        ),

        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
