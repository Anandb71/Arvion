import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

/// Button with neon glow effect behind (not on text)
class GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? glowColor;
  final bool isPrimary;
  final bool isLoading;
  final double? width;

  const GlowButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.glowColor,
    this.isPrimary = true,
    this.isLoading = false,
    this.width,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color =
        widget.glowColor ??
        (widget.isPrimary ? ArvionColors.primary : ArvionColors.secondary);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered && widget.onPressed != null
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 16,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: widget.isPrimary ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: widget.isPrimary
                    ? null
                    : Border.all(color: color, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.isLoading)
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: widget.isPrimary
                            ? ArvionColors.background
                            : color,
                      ),
                    )
                  else if (widget.icon != null)
                    Icon(
                      widget.icon,
                      size: 18,
                      color: widget.isPrimary ? ArvionColors.background : color,
                    ),
                  if ((widget.icon != null || widget.isLoading) &&
                      widget.label.isNotEmpty)
                    const SizedBox(width: 8),
                  if (widget.label.isNotEmpty)
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: widget.isPrimary
                            ? ArvionColors.background
                            : color,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Icon button with glow effect
class GlowIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? glowColor;
  final String? tooltip;
  final double size;

  const GlowIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.glowColor,
    this.tooltip,
    this.size = 40,
  });

  @override
  State<GlowIconButton> createState() => _GlowIconButtonState();
}

class _GlowIconButtonState extends State<GlowIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.glowColor ?? ArvionColors.primary;

    Widget button = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onPressed != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _isHovered ? ArvionColors.surfaceLight : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered && widget.onPressed != null
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: Icon(
                widget.icon,
                size: widget.size * 0.5,
                color: _isHovered ? color : ArvionColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      button = Tooltip(message: widget.tooltip!, child: button);
    }

    return button;
  }
}
