import 'dart:ui';

import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/theme/app_spacing.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: padding ?? const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: Border.all(color: Colors.white.withOpacity(.08)),
          ),
          child: child,
        ),
      ),
    );
  }
}
