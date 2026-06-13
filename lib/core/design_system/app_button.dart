import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool isSecondary;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isSecondary = false,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = widget.isSecondary 
        ? Colors.white 
        : theme.colorScheme.primary;
    final textColor = widget.isSecondary 
        ? theme.colorScheme.primary 
        : Colors.white;
    final borderSide = widget.isSecondary 
        ? BorderSide(color: theme.colorScheme.primary.withValues(alpha: 0.3))
        : BorderSide.none;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: (widget.onPressed == null || widget.isLoading)
          ? null 
          : widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.onPressed == null ? buttonColor.withValues(alpha: 0.5) : buttonColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.fromBorderSide(borderSide),
            boxShadow: widget.isSecondary ? null : [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: widget.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: textColor, size: 20),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.text,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
