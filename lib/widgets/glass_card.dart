import 'package:flutter/material.dart';
import 'dart:ui';
import '../core/theme/colors.dart';

/// Glassmorphic card with subtle blur and glow effects
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? glowColor;
  final bool hasGlow;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 12,
    this.glowColor,
    this.hasGlow = false,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ArvionColors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: ArvionColors.border.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );

    // Add glow effect if enabled
    if (hasGlow) {
      card = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: (glowColor ?? ArvionColors.primary).withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
        ),
        child: card,
      );
    }

    // Add margin if provided
    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    // Add tap handling
    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: onTap, child: card),
      );
    }

    return card;
  }
}

/// Solid card without glass effect (for better performance when many cards)
class SolidCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool isSelected;

  const SolidCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 12,
    this.backgroundColor,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? ArvionColors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: isSelected ? ArvionColors.primary : ArvionColors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: child,
    );

    if (margin != null) {
      card = Padding(padding: margin!, child: card);
    }

    if (onTap != null) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: onTap, child: card),
      );
    }

    return card;
  }
}
