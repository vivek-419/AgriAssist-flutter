import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Reusable AgriAssist Brand Logo Widget
/// Displays the custom AgriAssist emblem with smooth background matching,
/// elevation, and responsive dimension scaling.
class AppLogo extends StatelessWidget {
  final double size;
  final bool withCard;
  final bool withShadow;
  final bool isCircle;
  final BorderRadius? borderRadius;

  const AppLogo({
    super.key,
    this.size = 40.0,
    this.withCard = true,
    this.withShadow = true,
    this.isCircle = true,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = isCircle
        ? BorderRadius.circular(size / 2)
        : (borderRadius ?? BorderRadius.circular(size * 0.26));

    Widget imageWidget = Image.asset(
      'assets/images/app_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen,
            borderRadius: effectiveRadius,
          ),
          child: Icon(
            Icons.eco_rounded,
            color: Colors.white,
            size: size * 0.55,
          ),
        );
      },
    );

    if (!withCard) {
      return ClipRRect(
        borderRadius: effectiveRadius,
        child: imageWidget,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : effectiveRadius,
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                  blurRadius: size * 0.18,
                  offset: Offset(0, size * 0.04),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: size * 0.08,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: effectiveRadius,
        child: imageWidget,
      ),
    );
  }
}
