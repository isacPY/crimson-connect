import 'package:flutter/material.dart';

enum ButtonVariant {
  defaultVariant,
  destructive,
  outline,
  secondary,
  ghost,
  link
}

enum ButtonSize {
  defaultSize,
  sm,
  lg,
  icon
}

class MissionButton extends StatelessWidget {
  final String? label;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool fullWidth;
  final bool isLoading;

  const MissionButton({
    super.key,
    this.label,
    this.icon,
    required this.onPressed,
    this.variant = ButtonVariant.defaultVariant,
    this.size = ButtonSize.defaultSize,
    this.fullWidth = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Style configurations
    Color? backgroundColor;
    Color? foregroundColor;
    BorderSide? borderSide;
    double? elevation = 0;

    switch (variant) {
      case ButtonVariant.defaultVariant:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        break;
      case ButtonVariant.destructive:
        backgroundColor = colorScheme.error;
        foregroundColor = colorScheme.onError;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.onSurface;
        borderSide = BorderSide(color: colorScheme.outline);
        break;
      case ButtonVariant.secondary:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.onSurface;
        break;
      case ButtonVariant.link:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        break;
    }

    // Size configurations
    EdgeInsetsGeometry padding;
    TextStyle? textStyle = theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500);
    double height;

    switch (size) {
      case ButtonSize.sm:
        height = 36;
        padding = const EdgeInsets.symmetric(horizontal: 12);
        textStyle = textStyle?.copyWith(fontSize: 12);
        break;
      case ButtonSize.lg:
        height = 44;
        padding = const EdgeInsets.symmetric(horizontal: 32);
        textStyle = textStyle?.copyWith(fontSize: 16);
        break;
      case ButtonSize.icon:
        height = 40;
        padding = EdgeInsets.zero;
        break;
      case ButtonSize.defaultSize:
      default:
        height = 40;
        padding = const EdgeInsets.symmetric(horizontal: 16);
        break;
    }

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(foregroundColor),
            ),
          ),
          if (label != null) const SizedBox(width: 8),
        ] else if (icon != null && label != null) ...[
          IconTheme(data: IconThemeData(size: 16, color: foregroundColor), child: icon!),
          const SizedBox(width: 8),
        ],
        if (label != null)
           Text(label!, style: textStyle?.copyWith(color: foregroundColor)),
        if (isLoading == false && icon != null && label == null)
           IconTheme(data: IconThemeData(size: 16, color: foregroundColor), child: icon!),
      ],
    );

    // If ghost/link, use TextButton, else ElevatedButton/OutlinedButton mimicry
    // For consistency, we'll build a raw Material Button or use ElevatedButton with style overrides
    
    final buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          if (variant == ButtonVariant.ghost) return colorScheme.surfaceVariant.withOpacity(0.5);
          if (variant == ButtonVariant.outline) return colorScheme.surfaceVariant.withOpacity(0.1);
          // Darken/Lighten logic could go here
        }
        return backgroundColor;
      }),
      foregroundColor: MaterialStateProperty.all(foregroundColor),
      elevation: MaterialStateProperty.all(elevation),
      side: MaterialStateProperty.all(borderSide),
      padding: MaterialStateProperty.all(padding),
      minimumSize: MaterialStateProperty.all(Size(fullWidth ? double.infinity : 0, height)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))), // radius-md approx
      overlayColor: MaterialStateProperty.resolveWith((states) {
        if (variant == ButtonVariant.ghost || variant == ButtonVariant.outline) {
          return colorScheme.onSurface.withOpacity(0.1);
        }
        return Colors.white.withOpacity(0.1);
      }),
    );

    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: child,
    );
  }
}
