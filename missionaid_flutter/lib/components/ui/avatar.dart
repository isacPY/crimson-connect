import 'package:flutter/material.dart';

class MissionAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? fallbackText;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const MissionAvatar({
    super.key,
    this.imageUrl,
    this.fallbackText,
    this.size = 40.0,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.primaryContainer;
    final fgColor = foregroundColor ?? theme.colorScheme.onPrimaryContainer;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(color: theme.colorScheme.background, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildFallback(fgColor, theme),
              )
            : _buildFallback(fgColor, theme),
      ),
    );
  }

  Widget _buildFallback(Color fgColor, ThemeData theme) {
    return Center(
      child: Text(
        fallbackText?.substring(0, 1).toUpperCase() ?? "?",
        style: TextStyle(
          color: fgColor,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.4,
        ),
      ),
    );
  }
}
