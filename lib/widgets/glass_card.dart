import 'dart:ui';

import 'package:flutter/material.dart';



class GlassCard extends StatelessWidget {
  const GlassCard({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.88),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: colors.primary.withValues(alpha: 0.10),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}