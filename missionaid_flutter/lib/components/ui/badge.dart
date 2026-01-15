import 'package:flutter/material.dart';

enum BadgeVariant { defaultBadge, secondary, destructive, outline }

class MissionBadge extends StatelessWidget {
  final String label;
  final BadgeVariant variant;
  final Widget? icon;

  const MissionBadge({
    super.key,
    required this.label,
    this.variant = BadgeVariant.defaultBadge,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    Color bgColor;
    Color fgColor;
    BoxBorder? border;

    switch (variant) {
      case BadgeVariant.defaultBadge:
        bgColor = theme.colorScheme.primary;
        fgColor = theme.colorScheme.onPrimary;
        break;
      case BadgeVariant.secondary:
        bgColor = theme.colorScheme.secondaryContainer;
        fgColor = theme.colorScheme.onSecondaryContainer;
        break;
      case BadgeVariant.destructive:
        bgColor = theme.colorScheme.error;
        fgColor = theme.colorScheme.onError;
        break;
      case BadgeVariant.outline:
        bgColor = Colors.transparent;
        fgColor = theme.colorScheme.onSurface;
        border = Border.all(color: theme.colorScheme.outline);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
        border: border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(size: 14, color: fgColor),
              child: icon!,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: fgColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
